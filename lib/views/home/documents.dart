import 'package:flutter/material.dart';
import 'package:mvtravel/view_model/documents_view_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  /// Open images inside app only
  void _openIfImage(BuildContext context, String url) {
    final lowerUrl = url.toLowerCase();
    if (lowerUrl.contains('.jpg') ||
        lowerUrl.contains('.jpeg') ||
        lowerUrl.contains('.png')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: PhotoView(
              imageProvider: NetworkImage(url),
              loadingBuilder: (context, event) =>
                  const Center(child: CircularProgressIndicator()),
              backgroundDecoration: const BoxDecoration(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DocumentsViewModel()..fetchDocuments(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FD),
        appBar: AppBar(
          title: const Text(
            'Documents',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<DocumentsViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading)
              return const Center(child: CircularProgressIndicator());
            if (vm.errorMessage != null)
              return Center(child: Text('Error: ${vm.errorMessage}'));
            if (vm.documents.isEmpty)
              return const Center(child: Text('No documents found'));

            // ---------------- Work & Investment Documents ----------------
            final workDocs = vm.documents
                .where((d) => d.type == 'work')
                .toList();
            final investmentDocs = vm.documents
                .where((d) => d.type == 'investment')
                .toList();

            // ---------------- User Documents Grouped by Visa Country ----------------
            final Map<String, List<DocumentItem>> visaGroupedDocs = {};
            for (var doc in vm.documents.where((d) => d.type == 'user')) {
              final country = doc.visaCountry ?? 'Unknown Visa';
              visaGroupedDocs.putIfAbsent(country, () => []);
              visaGroupedDocs[country]!.add(doc);
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- User Documents ----------------
                  if (visaGroupedDocs.isNotEmpty) ...[
                    _buildSectionHeader('Visa Documents', Colors.deepPurple),
                    const SizedBox(height: 12),
                    ...visaGroupedDocs.entries.map((entry) {
                      final country = entry.key;
                      final docs = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 16),
                            child: Text(
                              'Visa – $country',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
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
                                  onTap: () => _openIfImage(context, doc.url),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],

                  // ---------------- Work Documents ----------------
                  if (workDocs.isNotEmpty) ...[
                    _buildSectionHeader('Work Documents', Colors.blueAccent),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: workDocs.asMap().entries.map((entry) {
                          final doc = entry.value;
                          return _buildDocumentItem(
                            context,
                            doc,
                            isLast: entry.key == workDocs.length - 1,
                            onTap: () => _openIfImage(context, doc.url),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // ---------------- Investment Documents ----------------
                  if (investmentDocs.isNotEmpty) ...[
                    _buildSectionHeader('Investment Documents', Colors.green),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: investmentDocs.asMap().entries.map((entry) {
                          final doc = entry.value;
                          return _buildDocumentItem(
                            context,
                            doc,
                            isLast: entry.key == investmentDocs.length - 1,
                            onTap: () => _openIfImage(context, doc.url),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
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
    DocumentItem doc, {
    required bool isLast,
    VoidCallback? onTap,
  }) {
    IconData icon;
    Color iconColor;

    final name = doc.name.toLowerCase();
    if (name.contains('.jpg') ||
        name.contains('.jpeg') ||
        name.contains('.png')) {
      icon = Icons.image_outlined;
      iconColor = Colors.orange;
    } else if (name.endsWith('.pdf')) {
      icon = Icons.picture_as_pdf_outlined;
      iconColor = Colors.red;
    } else if (name.endsWith('.doc') || name.endsWith('.docx')) {
      icon = Icons.description_outlined;
      iconColor = Colors.blue;
    } else if (doc.type == 'user') {
      icon = Icons.person_outline;
      iconColor = Colors.deepPurple;
    } else {
      icon = Icons.insert_drive_file_outlined;
      iconColor = Colors.grey;
    }

    return GestureDetector(
      onTap: onTap, // only photos will respond
      child: Container(
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doc.type == 'work'
                          ? 'Work Document'
                          : doc.type == 'investment'
                          ? 'Investment Document'
                          : 'User Document',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
