import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportePdfService {
  static Future<void> generarYGuardar({
    required double pesoInicial,
    required double pesoFinal,
    required double pesoHumedo,
    required double humedad,
    required double arenaUsada,
    required double arenaHueco,
    required double volumen,
    required double densidad,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Encabezado
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColors.blue800,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'CivilCalc',
                      style: pw.TextStyle(
                        fontSize: 26,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Reporte de Ensayo – Cono y Arena',
                      style: pw.TextStyle(
                        fontSize: 13,
                        color: PdfColors.blue100,
                      ),
                    ),
                  ],
                ),
              ),

              pw.SizedBox(height: 20),

              // Fecha
              pw.Text(
                'Fecha: ${_fechaActual()}',
                style: pw.TextStyle(fontSize: 11, color: PdfColors.grey700),
              ),

              pw.SizedBox(height: 20),

              // Datos de entrada
              _seccion('Datos de Entrada'),
              pw.SizedBox(height: 8),
              _tabla([
                ['Peso frasco + arena inicial', '${pesoInicial.toStringAsFixed(2)} g'],
                ['Peso frasco + arena restante', '${pesoFinal.toStringAsFixed(2)} g'],
                ['Peso material húmedo', '${pesoHumedo.toStringAsFixed(2)} g'],
                ['Humedad', '${humedad.toStringAsFixed(2)} %'],
              ]),

              pw.SizedBox(height: 20),

              // Resultados
              _seccion('Resultados Calculados'),
              pw.SizedBox(height: 8),
              _tabla([
                ['Arena usada', '${arenaUsada.toStringAsFixed(3)} g'],
                ['Arena en el hueco', '${arenaHueco.toStringAsFixed(3)} g'],
                ['Volumen del hueco', '${volumen.toStringAsFixed(3)} cm³'],
                ['Densidad seca', '${densidad.toStringAsFixed(3)} g/cm³'],
              ], destacarUltima: true),

              pw.SizedBox(height: 30),

              // Fórmulas
              _seccion('Fórmulas Aplicadas'),
              pw.SizedBox(height: 8),
              _formulaItem('Arena usada', 'Peso inicial − Peso final'),
              _formulaItem('Arena en hueco', 'Arena usada − Constante del cono'),
              _formulaItem('Volumen', 'Arena en hueco / Densidad de arena'),
              _formulaItem('Peso seco', 'Peso húmedo / (1 + Humedad)'),
              _formulaItem('Densidad seca', 'Peso seco / Volumen'),

              pw.Spacer(),

              // Footer
              pw.Divider(color: PdfColors.grey300),
              pw.SizedBox(height: 6),
              pw.Text(
                '"Menos papel, más precisión, mejor ingeniería." – CivilCalc',
                style: pw.TextStyle(
                  fontSize: 9,
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey500,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ],
          );
        },
      ),
    );

    // Abre el diálogo de guardar / compartir / imprimir
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'reporte_cono_arena_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
  }

  // ─── Helpers ────────────────────────────────────────────────────────────────

  static String _fechaActual() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/'
        '${now.year}  '
        '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';
  }

  static pw.Widget _seccion(String titulo) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          left: pw.BorderSide(color: PdfColors.blue700, width: 4),
        ),
      ),
      child: pw.Text(
        titulo,
        style: pw.TextStyle(
          fontSize: 13,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue800,
        ),
      ),
    );
  }

  static pw.Widget _tabla(List<List<String>> filas,
      {bool destacarUltima = false}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(2),
      },
      children: filas.asMap().entries.map((entry) {
        final isLast = destacarUltima && entry.key == filas.length - 1;
        final isEven = entry.key % 2 == 0;
        return pw.TableRow(
          decoration: pw.BoxDecoration(
            color: isLast
                ? PdfColors.blue50
                : isEven
                    ? PdfColors.grey100
                    : PdfColors.white,
          ),
          children: entry.value.map((cell) {
            return pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: pw.Text(
                cell,
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight:
                      isLast ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: isLast ? PdfColors.blue800 : PdfColors.black,
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  static pw.Widget _formulaItem(String nombre, String formula) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 3),
      child: pw.Row(
        children: [
          pw.Text('• ', style: pw.TextStyle(color: PdfColors.blue700)),
          pw.Text('$nombre:  ',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
          pw.Text(formula,
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
        ],
      ),
    );
  }
}   