import 'package:flutter/material.dart';
import 'package:mvtravel/utilis/colors.dart';
import 'package:mvtravel/view_model/documents_view_model.dart';
import 'package:provider/provider.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  void _openDocument(BuildContext context, DocumentItem doc) {
    if (doc.url.isEmpty) return;

    // External or future handling can be added here
    print('Document tapped: ${doc.name} -> ${doc.url}');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentsViewModel()..fetchDocuments(),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 70),
          child: FloatingActionButton(
            shape: CircleBorder(),
            heroTag: 'chat2',
            onPressed: () {},
            backgroundColor: AppColors.blue2,
            child: const Icon(Icons.add, color: AppColors.white),
          ),
        ),
        backgroundColor: const Color(0xFFF8F9FD),
        appBar: AppBar(
          title: const Text(
            'Documents',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xFF1A237E),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Color(0xFF1A237E)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: const Color(0xFFE8EAF6)),
          ),
        ),
        body: Consumer<DocumentsViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5C6BC0)),
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
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${vm.errorMessage}',
                      style: const TextStyle(fontSize: 16),
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
                            const Color(0xFF5C6BC0).withOpacity(0.2),
                            const Color(0xFF7986CB).withOpacity(0.1),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.folder_open,
                        size: 48,
                        color: Color(0xFF5C6BC0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No documents found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            final workDocs = vm.documents
                .where((d) => d.type == 'work')
                .toList();
            final investmentDocs = vm.documents
                .where((d) => d.type == 'investment')
                .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (workDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Work Documents',
                      const Color(0xFF1976D2),
                      const Color(0xFF42A5F5),
                      // Icons.work_outline,
                    ),
                    const SizedBox(height: 12),
                    _buildContainer(
                      workDocs,
                      context,
                      // onTap: (doc) => _openDocument(context, doc),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (investmentDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Investment Document',
                      const Color(0xFF0288D1),
                      const Color(0xFF03A9F4),
                      // Icons.trending_up,
                    ),
                    const SizedBox(height: 12),
                    _buildContainer(investmentDocs, context, onTap: null),
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
    BuildContext context, {
    VoidCallback? Function(DocumentItem doc)? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBBDEFB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF42A5F5).withOpacity(0.08),
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
            isLast: entry.key == docs.length - 1,
            onTap: onTap?.call(doc),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color1, Color color2) {
    return Row(
      children: [
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color1,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem(
    BuildContext context,
    DocumentItem doc, {
    required bool isLast,
    VoidCallback? onTap,
  }) {
    final arrowColor = doc.type == 'work'
        ? const Color(0xFF1976D2)
        : const Color(0xFF0288D1);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: isLast
                ? null
                : const Border(
                    bottom: BorderSide(color: Color(0xFFF5F6FA), width: 1.5),
                  ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file_outlined,
                color: arrowColor,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  doc.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF1A237E),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
