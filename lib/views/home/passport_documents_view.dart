import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/documents_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';

class PassportDocumentsView extends StatefulWidget {
  const PassportDocumentsView({super.key});

  @override
  State<PassportDocumentsView> createState() => _PassportDocumentsViewState();
}

class _PassportDocumentsViewState extends State<PassportDocumentsView> {
  bool isSelecting = false;

  final Map<String, bool> selectedDocs = {};

  Future<void> _openDocument(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not open document: $url');
    }
  }

  void _openImage(BuildContext context, String url) {
    if (url.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            backgroundColor: AppColors.black,
            iconTheme: const IconThemeData(color: AppColors.white),
            elevation: 0,
          ),
          body: PhotoView(
            imageProvider: NetworkImage(url),
            backgroundDecoration: const BoxDecoration(color: AppColors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentsViewModel()..fetchDocuments(),
      child: Scaffold(
        backgroundColor: AppColors.grey,
        appBar: AppBar(
          title: const Text(
            'List of Documents',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.blue3,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.blue3),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: AppColors.grey1),
          ),
        ),
        body: Consumer<DocumentsViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.blue2),
                ),
              );
            }
            final userDocs = vm.documents
                .where((d) => d.type == 'user' || d.type.isEmpty)
                .toList();
            if (userDocs.isEmpty) {
              return const Center(
                child: Text(
                  'No documents found',
                  style: TextStyle(color: AppColors.black, fontSize: 16),
                ),
              );
            }

            if (vm.errorMessage != null) {
              return Center(
                child: Text(
                  'Error: ${vm.errorMessage}',
                  style: const TextStyle(color: AppColors.black),
                ),
              );
            }

            // Initialize selection map
            for (var doc in userDocs) {
              selectedDocs.putIfAbsent(doc.name, () => false);
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: userDocs.length,
                    itemBuilder: (context, index) {
                      final doc = userDocs[index];
                      final isImage =
                          doc.url.toLowerCase().endsWith('.jpg') ||
                          doc.url.toLowerCase().endsWith('.jpeg') ||
                          doc.url.toLowerCase().endsWith('.png') ||
                          doc.url.toLowerCase().endsWith('.webp');

                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        leading: Checkbox(
                          value: selectedDocs[doc.name],
                          onChanged: (value) {
                            setState(() {
                              selectedDocs.updateAll((key, val) => false);
                              selectedDocs[doc.name] = value ?? false;
                            });
                          },
                          fillColor: MaterialStateProperty.resolveWith<Color>((
                            states,
                          ) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors
                                  .blue2; // ✅ selected checkbox color
                            }
                            return AppColors.grey1; // ✅ unselected color
                          }),
                          checkColor: AppColors.white, // ✅ tick color
                        ),

                        title: Text(
                          doc.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blue3,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.visibility_outlined,
                            color: AppColors.blue2,
                          ),
                          onPressed: () {
                            if (isImage) {
                              _openImage(context, doc.url);
                            } else {
                              _openDocument(doc.url);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isSelecting
                          ? null
                          : () async {
                              // disable button when selecting
                              final selectedEntry = selectedDocs.entries
                                  .firstWhere(
                                    (e) => e.value,
                                    orElse: () => const MapEntry('', false),
                                  );

                              if (selectedEntry.key.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select a document'),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                isSelecting = true; // start selecting
                              });

                              try {
                                final vm = context.read<DocumentsViewModel>();
                                final doc = vm.documents.firstWhere(
                                  (d) => d.name == selectedEntry.key,
                                );
                                final file = await vm.downloadDocumentAsFile(
                                  doc.url,
                                );

                                Navigator.pop(
                                  context,
                                  file,
                                ); // return File to caller
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    isSelecting = false; // stop selecting
                                  });
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelecting
                            ? AppColors.grey1
                            : AppColors.blue2, // change color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isSelecting ? 'Selecting...' : 'Select',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
