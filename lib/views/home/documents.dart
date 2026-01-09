import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/documents_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  /// Open document via URL
  Future<void> _openDocument(String url) async {
    if (url.isEmpty) return;

    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // opens in browser
    )) {
      debugPrint('Could not open document: $url');
    }
  }

  /// Open image in fullscreen
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

  /// Show delete confirmation dialog
  /// Show delete confirmation dialog
  Future<void> _showDeleteConfirmation(
    BuildContext context,
    DocumentItem doc,
    DocumentsViewModel vm,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Document',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.blue3,
            fontSize: 16,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${doc.name}"?',
          style: const TextStyle(color: AppColors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.black),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Call the delete logic from ViewModel
      await vm.deleteUserDocument(doc);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(child: Text('${doc.name} deleted')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentsViewModel()..fetchDocuments(),
      child: Scaffold(
        floatingActionButton: Consumer<DocumentsViewModel>(
          builder: (context, vm, child) {
            return Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 70),
              child: FloatingActionButton(
                shape: const CircleBorder(),
                heroTag: 'chat2',
                onPressed: () async {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (_) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.image,
                                color: AppColors.blue2,
                              ),
                              title: const Text(
                                'Pick Image',
                                style: TextStyle(color: AppColors.black),
                              ),
                              onTap: () async {
                                Navigator.pop(context);
                                final pickedFile = await vm
                                    .pickImageFromGallery();
                                if (pickedFile != null) {
                                  await vm.uploadUserFile(
                                    file: pickedFile,
                                    name: pickedFile.path.split('/').last,
                                    fileType: 'user',
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Image uploaded successfully!',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.insert_drive_file,
                                color: AppColors.blue2,
                              ),
                              title: const Text(
                                'Pick File',
                                style: TextStyle(color: AppColors.black),
                              ),
                              onTap: () async {
                                Navigator.pop(context);
                                final pickedFile = await vm
                                    .pickDocumentFromDevice();
                                if (pickedFile != null) {
                                  await vm.uploadUserFile(
                                    file: pickedFile,
                                    name: pickedFile.path.split('/').last,
                                    fileType: 'user',
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'File uploaded successfully!',
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                backgroundColor: AppColors.blue2,
                child: const Icon(Icons.add, color: AppColors.white),
              ),
            );
          },
        ),
        backgroundColor: AppColors.grey,
        appBar: AppBar(
          title: const Text(
            'Documents',
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: AppColors.grey1),
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

            if (vm.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppColors.blue2.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${vm.errorMessage}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (vm.documents.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.blue2.withOpacity(0.2),
                            AppColors.blue1.withOpacity(0.1),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.folder_open,
                        size: 48,
                        color: AppColors.blue2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No documents found',
                      style: TextStyle(fontSize: 16, color: AppColors.grey),
                    ),
                  ],
                ),
              );
            }

            // Filter documents by type
            final workDocs = vm.documents
                .where((d) => d.type == 'work')
                .toList();
            final investmentDocs = vm.documents
                .where((d) => d.type == 'investment')
                .toList();
            final userDocs = vm.documents
                .where((d) => d.type == 'user')
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (workDocs.isNotEmpty) ...[
                    _buildSectionHeader('Work Documents', AppColors.blue2),
                    const SizedBox(height: 12),
                    _buildContainer(workDocs, context, vm),
                    const SizedBox(height: 24),
                  ],
                  if (investmentDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Investment Documents',
                      AppColors.blue1,
                    ),
                    const SizedBox(height: 12),
                    _buildContainer(investmentDocs, context, vm),
                    const SizedBox(height: 24),
                  ],
                  if (userDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'All Uploaded Documents',
                      AppColors.blue1,
                    ),
                    const SizedBox(height: 12),
                    _buildContainer(userDocs, context, vm, showDelete: true),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContainer(
    List<DocumentItem> docs,
    BuildContext context,
    DocumentsViewModel vm, {
    bool showDelete = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.blue.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue2.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: docs.asMap().entries.map((entry) {
          final doc = entry.value;
          return _buildDocumentItem(
            context,
            doc,
            vm,
            isLast: entry.key == docs.length - 1,
            showDelete: showDelete,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem(
    BuildContext context,
    DocumentItem doc,
    DocumentsViewModel vm, {
    required bool isLast,
    bool showDelete = false,
  }) {
    final isImage =
        doc.url.endsWith('.jpg') ||
        doc.url.endsWith('.png') ||
        doc.url.endsWith('.jpeg') ||
        doc.url.endsWith('.webp');

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(bottom: BorderSide(color: AppColors.grey1, width: 1.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Image/Document Icon
            if (isImage)
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.blue2.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blue2.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    doc.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.grey.withOpacity(0.3),
                        child: const Icon(
                          Icons.broken_image,
                          color: AppColors.grey,
                          size: 30,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: AppColors.grey.withOpacity(0.3),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.blue2,
                              ),
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.blue2.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.blue2.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.insert_drive_file_outlined,
                  color: AppColors.blue1,
                  size: 32,
                ),
              ),
            const SizedBox(width: 16),

            // Document Name
            Expanded(
              child: Text(
                doc.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: AppColors.blue3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const SizedBox(width: 8),

            // Preview Icon
            IconButton(
              onPressed: () {
                if (isImage) {
                  _openImage(context, doc.url);
                } else {
                  _openDocument(doc.url);
                }
              },
              icon: const Icon(
                Icons.visibility_outlined,
                color: AppColors.blue2,
                size: 24,
              ),
              tooltip: 'Preview',
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),

            // Delete Icon (only for user documents)
            if (showDelete) ...[
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => _showDeleteConfirmation(context, doc, vm),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 24,
                ),
                tooltip: 'Delete',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
