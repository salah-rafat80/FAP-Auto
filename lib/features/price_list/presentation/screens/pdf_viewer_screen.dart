import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:fap/core/utils/size_config.dart';
import 'package:fap/core/utils/auth_session.dart';
import 'package:fap/injection_container.dart';
import 'package:fap/features/price_list/presentation/widgets/pdf_loading_view.dart';
import 'package:fap/features/price_list/presentation/widgets/pdf_error_view.dart';
import 'package:fap/features/price_list/presentation/widgets/pdf_zoom_controls.dart';

/// PDF viewer screen to display price list PDFs from URL or assets
class PdfViewerScreen extends StatefulWidget {
  final String title;
  final String pdfAssetPath;

  const PdfViewerScreen({
    super.key,
    required this.title,
    required this.pdfAssetPath,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _hasError = false;
  bool _isLoading = true;
  bool _snackShown = false;
  String? _errorMessage;
  String? _userName;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  late final bool _isNetworkUrl;
  late final Widget _viewer; // ثبّت الويدجت لتجنب إعادة الإنشاء مع كل build

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _isNetworkUrl =
        widget.pdfAssetPath.startsWith('http://') ||
        widget.pdfAssetPath.startsWith('https://');

    final viewerKey = ValueKey(widget.pdfAssetPath);

    if (_isNetworkUrl) {
      _viewer = SfPdfViewer.network(
        widget.pdfAssetPath,
        key: viewerKey,
        controller: _pdfViewerController,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        scrollDirection: PdfScrollDirection.vertical,
        enableDoubleTapZooming: true,
        enableTextSelection: false,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        canShowPaginationDialog: true,
        interactionMode: PdfInteractionMode.pan,
        onDocumentLoaded: (details) {
          if (!mounted) return;
          if (_isLoading) {
            setState(() => _isLoading = false);
          }
          if (!_snackShown) {
            _snackShown = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم تحميل ${details.document.pages.count} صفحة'),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        onDocumentLoadFailed: (details) {
          if (!mounted) return;
          setState(() {
            _hasError = true;
            _isLoading = false;
            _errorMessage = details.description;
          });
        },
      );
    } else {
      _viewer = SfPdfViewer.asset(
        widget.pdfAssetPath,
        key: viewerKey,
        controller: _pdfViewerController,
        pageLayoutMode: PdfPageLayoutMode.continuous,
        scrollDirection: PdfScrollDirection.vertical,
        enableDoubleTapZooming: true,
        enableTextSelection: false,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        canShowPaginationDialog: true,
        interactionMode: PdfInteractionMode.pan,
        onDocumentLoaded: (_) {
          if (!mounted) return;
          if (_isLoading) {
            setState(() => _isLoading = false);
          }
        },
        onDocumentLoadFailed: (details) {
          if (!mounted) return;
          setState(() {
            _hasError = true;
            _isLoading = false;
            _errorMessage = details.description;
          });
        },
      );
    }
  }

  void _loadUserName() {
    final authSession = sl<AuthSession>();
    _userName = authSession.userName ?? 'FAP';
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  /// Build watermark text widget
  Widget _buildWatermarkText() {
    return Transform.rotate(
      angle: -0.5, // ~30 degrees rotation
      child: Opacity(
        opacity: 0.19,
        child: Text(
          _userName ?? 'FAP',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.5,
            fontFamily: 'Tajawal',
          ),
        ),
      ),
    );
  }

  /// Build multiple watermarks across the screen
  Widget _buildWatermarkOverlay() {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: _buildWatermarkText()),

                Flexible(child: _buildWatermarkText()),

                SizedBox(width: 25),
              ],
            ),
            // Middle row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: _buildWatermarkText()),
                Flexible(child: _buildWatermarkText()),
                SizedBox(width: 25),
              ],
            ),
            // Bottom row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: _buildWatermarkText()),
                Flexible(child: _buildWatermarkText()),
                SizedBox(width: 25),
              ],
            ),
            // Extra row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: _buildWatermarkText()),
                Flexible(child: _buildWatermarkText()),
                SizedBox(width: 25),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: _buildWatermarkText()),
                Flexible(child: _buildWatermarkText()),
                SizedBox(width: 25),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(child: _buildWatermarkText()),
                Flexible(child: _buildWatermarkText()),
                SizedBox(width: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            if (!_hasError && !_isLoading)
              PdfZoomControls(
                onZoomIn: () {
                  _pdfViewerController.zoomLevel =
                      _pdfViewerController.zoomLevel + 0.25;
                },
                onZoomOut: () {
                  _pdfViewerController.zoomLevel =
                      _pdfViewerController.zoomLevel - 0.25;
                },
              ),
          ],
        ),
        body: SafeArea(
          child: _hasError
              ? PdfErrorView(
                  errorMessage: _errorMessage,
                  pdfPath: widget.pdfAssetPath,
                  onRetry: () {
                    setState(() {
                      _hasError = false;
                      _isLoading = true;
                      _snackShown = false;
                    });
                  },
                  onBack: () => Navigator.pop(context),
                )
              : Stack(
                  children: [
                    Positioned.fill(child: _viewer),
                    if (_isLoading) const PdfLoadingView(),
                    // Multiple watermarks overlay with user name
                    Positioned.fill(child: _buildWatermarkOverlay()),
                  ],
                ),
        ),
      ),
    );
  }
}
