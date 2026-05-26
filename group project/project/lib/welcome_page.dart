import 'dart:math' as math;

import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          final compact = height < 740;
          final tight = height < 660;
          final logoTextSize = tight ? 24.0 : 28.0;
          final logoMarkHeight = tight ? 20.0 : 25.0;
          final titleSize = tight ? 30.0 : (compact ? 33.0 : 36.0);
          final bodySize = tight ? 13.5 : 15.0;
          final buttonHeight = tight ? 50.0 : 58.0;
          final artworkHeight =
              height * (tight ? 0.2 : (compact ? 0.23 : 0.265));

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/background.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width < 360 ? 24 : 32,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: height * (tight ? 0.005 : 0.014)),
                          _SolunaLogo(
                            markHeight: logoMarkHeight,
                            textSize: logoTextSize,
                          ),
                          SizedBox(height: height * (tight ? 0.01 : 0.026)),
                          SizedBox(
                            height: artworkHeight,
                            width: math.min(width * 0.74, 310),
                            child: const CustomPaint(
                              painter: _MoonGardenPainter(),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Begin your\nquiet ritual',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff25150f),
                              fontFamily: 'serif',
                              fontSize: titleSize,
                              fontWeight: FontWeight.w700,
                              height: 1.08,
                            ),
                          ),
                          SizedBox(height: compact ? 10 : 16),
                          const _OrnamentDivider(),
                          SizedBox(height: compact ? 14 : 22),
                          Text(
                            'A gentle space for journaling, intentions,\nemotions, and mindful routines.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff5f5b5c),
                              fontSize: bodySize,
                              height: 1.42,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(flex: 2),
                          _GetStartedButton(height: buttonHeight),
                          SizedBox(height: compact ? 12 : 18),
                          const _LoginPrompt(),
                          SizedBox(height: compact ? 8 : 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SolunaLogo extends StatelessWidget {
  const _SolunaLogo({required this.markHeight, required this.textSize});

  final double markHeight;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: markHeight,
          width: markHeight * 2.05,
          child: const CustomPaint(painter: _SolunaMarkPainter()),
        ),
        SizedBox(height: markHeight < 24 ? 2 : 4),
        Text(
          'Soluna',
          style: TextStyle(
            color: const Color(0xff2b1b16),
            fontFamily: 'serif',
            fontSize: textSize,
            fontWeight: FontWeight.w500,
            shadows: [const Shadow(color: Color(0x8cffffff), blurRadius: 8)],
          ),
        ),
      ],
    );
  }
}

class _OrnamentDivider extends StatelessWidget {
  const _OrnamentDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Row(
        children: const [
          Expanded(child: _SoftLine()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              height: 12,
              width: 12,
              child: CustomPaint(painter: _TinyStarPainter()),
            ),
          ),
          Expanded(child: _SoftLine()),
        ],
      ),
    );
  }
}

class _SoftLine extends StatelessWidget {
  const _SoftLine();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: const Color(0x33a87a62));
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            colors: [Color(0xffcaa6ff), Color(0xff8d6add)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f8163c8),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () {},
            child: const Center(
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(color: Color(0xff696364), fontSize: 14.5, height: 1.2),
        children: [
          TextSpan(text: 'Already have an account? '),
          TextSpan(
            text: 'Log in',
            style: TextStyle(
              color: Color(0xff7a63c9),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SolunaMarkPainter extends CustomPainter {
  const _SolunaMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = const Color(0xff3a241b)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final dot = Paint()
      ..color = const Color(0xff3a241b)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height * 0.63);
    canvas.drawCircle(center, 2.5, dot);

    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: size.width * 0.44,
        height: size.height * 0.72,
      ),
      math.pi * 1.05,
      math.pi * 0.9,
      false,
      line,
    );

    for (var i = -4; i <= 4; i++) {
      final angle = -math.pi / 2 + i * 0.18;
      final start = center + Offset(math.cos(angle), math.sin(angle)) * 8;
      final end = center + Offset(math.cos(angle), math.sin(angle)) * 15;
      canvas.drawLine(start, end, line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MoonGardenPainter extends CustomPainter {
  const _MoonGardenPainter();

  static const _ink = Color(0xffa7754d);
  static const _softInk = Color(0x55a7754d);

  @override
  void paint(Canvas canvas, Size size) {
    final shortest = math.min(size.width, size.height);
    final baseStroke = shortest / 180;

    final fineLine = Paint()
      ..color = _ink
      ..strokeWidth = math.max(0.9, baseStroke)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final faintLine = Paint()
      ..color = _softInk
      ..strokeWidth = 0.75
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final sparklePaint = Paint()
      ..color = _ink
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(size.width * 0.5, size.height * 0.5);
    final scale = shortest / 280;
    canvas.scale(scale);
    canvas.translate(-140, -140);

    _drawOrbit(canvas, faintLine);
    _drawCrescent(canvas, fineLine);
    _drawBranch(canvas, fineLine);

    _drawSparkle(canvas, const Offset(145, 18), 18, sparklePaint);
    _drawSparkle(canvas, const Offset(249, 95), 11, sparklePaint);
    _drawSparkle(canvas, const Offset(86, 222), 7, sparklePaint);
    _drawSparkle(canvas, const Offset(207, 205), 7, sparklePaint);
    _drawSparkle(canvas, const Offset(24, 118), 6, sparklePaint);
    _drawSparkle(canvas, const Offset(178, 112), 5, sparklePaint);

    _drawDot(canvas, const Offset(232, 39), 1.5);
    _drawDot(canvas, const Offset(66, 63), 1.1);
    _drawDot(canvas, const Offset(111, 91), 1.2);
    _drawDot(canvas, const Offset(233, 145), 1.2);
    _drawDot(canvas, const Offset(41, 187), 1.0);
    _drawDot(canvas, const Offset(196, 68), 1.1);

    canvas.restore();
  }

  void _drawOrbit(Canvas canvas, Paint paint) {
    canvas.drawArc(
      Rect.fromCenter(center: const Offset(140, 143), width: 262, height: 205),
      math.pi * 1.13,
      math.pi * 1.18,
      false,
      paint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: const Offset(141, 145), width: 316, height: 244),
      math.pi * 1.04,
      math.pi * 1.09,
      false,
      Paint()
        ..color = const Color(0x35ffffff)
        ..strokeWidth = 0.75
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  void _drawCrescent(Canvas canvas, Paint paint) {
    final outer = Path()
      ..moveTo(168, 65)
      ..cubicTo(216, 76, 237, 123, 217, 166)
      ..cubicTo(199, 205, 157, 229, 116, 211);
    canvas.drawPath(outer, paint);

    final inner = Path()
      ..moveTo(168, 65)
      ..cubicTo(108, 72, 78, 132, 102, 176)
      ..cubicTo(116, 202, 140, 215, 116, 211);
    canvas.drawPath(inner, paint);
  }

  void _drawBranch(Canvas canvas, Paint paint) {
    final stem = Path()
      ..moveTo(76, 190)
      ..cubicTo(58, 156, 57, 119, 78, 78);
    canvas.drawPath(stem, paint);

    final leaves = [
      _Leaf(const Offset(71, 177), -2.65, 18),
      _Leaf(const Offset(63, 160), -2.88, 17),
      _Leaf(const Offset(60, 141), -3.05, 17),
      _Leaf(const Offset(65, 121), -3.17, 16),
      _Leaf(const Offset(73, 101), -3.23, 16),
      _Leaf(const Offset(84, 85), -3.42, 15),
      _Leaf(const Offset(83, 180), -0.37, 19),
      _Leaf(const Offset(80, 160), -0.28, 18),
      _Leaf(const Offset(78, 140), -0.13, 17),
      _Leaf(const Offset(80, 120), 0.08, 16),
      _Leaf(const Offset(86, 101), 0.23, 15),
    ];

    for (final leaf in leaves) {
      _drawLeaf(canvas, paint, leaf.center, leaf.angle, leaf.length);
    }

    final berries = Paint()
      ..color = _ink
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(58, 145), 1.4, berries);
    canvas.drawCircle(const Offset(90, 131), 1.2, berries);
    canvas.drawCircle(const Offset(70, 106), 1.1, berries);
  }

  void _drawLeaf(
    Canvas canvas,
    Paint paint,
    Offset center,
    double angle,
    double length,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    final width = length * 0.32;
    final leaf = Path()
      ..moveTo(0, 0)
      ..cubicTo(length * 0.35, -width, length * 0.75, -width, length, 0)
      ..cubicTo(length * 0.75, width, length * 0.35, width, 0, 0);
    canvas.drawPath(leaf, paint);
    canvas.drawLine(Offset.zero, Offset(length * 0.78, 0), paint);

    canvas.restore();
  }

  void _drawSparkle(Canvas canvas, Offset center, double radius, Paint paint) {
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      paint,
    );

    final short = radius * 0.42;
    final diagonalPaint = Paint()
      ..color = const Color(0x9ea7754d)
      ..strokeWidth = paint.strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(center.dx - short, center.dy - short),
      Offset(center.dx + short, center.dy + short),
      diagonalPaint,
    );
    canvas.drawLine(
      Offset(center.dx + short, center.dy - short),
      Offset(center.dx - short, center.dy + short),
      diagonalPaint,
    );
  }

  void _drawDot(Canvas canvas, Offset center, double radius) {
    final dot = Paint()
      ..color = _ink
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Leaf {
  const _Leaf(this.center, this.angle, this.length);

  final Offset center;
  final double angle;
  final double length;
}

class _TinyStarPainter extends CustomPainter {
  const _TinyStarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = const Color(0xffa7754d)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, size.height),
      paint,
    );
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
