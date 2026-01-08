import 'package:flutter/material.dart';
import 'package:mvtravel/view_model/documents_view_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class DocumentsScreen extends StatelessWidget {
  void _openDocument(BuildContext context, DocumentItem doc) {
    if (doc.url.isEmpty) return;

    final lowerName = doc.name.toLowerCase();
    if (lowerName.endsWith('.jpg') ||
        lowerName.endsWith('.jpeg') ||
        lowerName.endsWith('.png')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                doc.name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: PhotoView(
              imageProvider: NetworkImage(doc.url),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ),
      );
    } else {
      // If not an image (pdf/doc), you can open externally
      print('Non-image document tapped: ${doc.name} -> ${doc.url}');
    }
  }

  const DocumentsScreen({super.key});

  /// Open user images (photo & passport) inside app
  void _openIfUserImage(BuildContext context, DocumentItem doc) {
    if (doc.type == 'user' && doc.url.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                doc.name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: PhotoView(
              imageProvider: NetworkImage(doc.url),
              loadingBuilder: (context, event) => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
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
            final Map<String, List<DocumentItem>> visaDocs = {};

            for (var doc in vm.documents.where((d) => d.type == 'user')) {
              final country = doc.visaCountry ?? 'Unknown Visa';
              visaDocs.putIfAbsent(country, () => []);
              visaDocs[country]!.add(doc);
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (visaDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Visa Documents',
                      const Color(0xFF3F51B5),
                      const Color(0xFF5C6BC0),
                      Icons.flight_takeoff,
                    ),
                    const SizedBox(height: 12),
                    ...visaDocs.entries.map((entry) {
                      final country = entry.key;
                      final docs = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 16),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(
                                          0xFF5C6BC0,
                                        ).withOpacity(0.15),
                                        const Color(
                                          0xFF7986CB,
                                        ).withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.public,
                                        size: 14,
                                        color: Color(0xFF3F51B5),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        country,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF3F51B5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFE8EAF6),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5C6BC0,
                                  ).withOpacity(0.08),
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
                                  onTap: () => _openIfUserImage(context, doc),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],
                  if (workDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Work Documents',
                      const Color(0xFF1976D2),
                      const Color(0xFF42A5F5),
                      Icons.work_outline,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFBBDEFB),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF42A5F5).withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
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
                            onTap: () => _openDocument(context, doc),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (investmentDocs.isNotEmpty) ...[
                    _buildSectionHeader(
                      'Investment Documents',
                      const Color(0xFF0288D1),
                      const Color(0xFF03A9F4),
                      Icons.trending_up,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFB3E5FC),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF03A9F4).withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
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
                            onTap: null,
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    Color color1,
    Color color2,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color1.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
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
    IconData icon;
    List<Color> iconGradient;

    if (doc.type == 'user') {
      icon = Icons.image_outlined;
      iconGradient = [const Color(0xFF5C6BC0), const Color(0xFF7986CB)];
    } else if (doc.name.toLowerCase().endsWith('.pdf')) {
      icon = Icons.picture_as_pdf_outlined;
      iconGradient = [const Color(0xFFE53935), const Color(0xFFEF5350)];
    } else if (doc.name.toLowerCase().endsWith('.doc') ||
        doc.name.toLowerCase().endsWith('.docx')) {
      icon = Icons.description_outlined;
      iconGradient = [const Color(0xFF1976D2), const Color(0xFF42A5F5)];
    } else {
      icon = Icons.insert_drive_file_outlined;
      iconGradient = [const Color(0xFF90CAF9), const Color(0xFFBBDEFB)];
    }

    // Different arrow colors based on document type
    Color arrowColor;
    if (doc.type == 'user') {
      arrowColor = const Color(0xFF5C6BC0);
    } else if (doc.type == 'work') {
      arrowColor = const Color(0xFF1976D2);
    } else {
      arrowColor = const Color(0xFF0288D1);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.only(
          bottomLeft: isLast ? const Radius.circular(16) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(16) : Radius.zero,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: isLast
                ? null
                : const Border(
                    bottom: BorderSide(color: Color(0xFFF5F6FA), width: 1.5),
                  ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [arrowColor, arrowColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: arrowColor.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        iconGradient[0].withOpacity(0.15),
                        iconGradient[1].withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: iconGradient[1].withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(icon, color: iconGradient[0], size: 28),
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
                          color: Color(0xFF1A237E),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  arrowColor.withOpacity(0.15),
                                  arrowColor.withOpacity(0.08),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: arrowColor.withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              doc.type == 'work'
                                  ? 'Work'
                                  : doc.type == 'investment'
                                  ? 'Investment'
                                  : 'User',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: arrowColor,
                              ),
                            ),
                          ),
                          if (doc.type == 'user' && doc.url.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF5C6BC0),
                                    Color(0xFF7986CB),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF5C6BC0,
                                    ).withOpacity(0.25),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 11,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    'Preview',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
