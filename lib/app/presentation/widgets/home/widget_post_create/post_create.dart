import 'package:flutter/material.dart';

class PostCreate extends StatefulWidget {
  const PostCreate({super.key});

  @override
  State<PostCreate> createState() => _PostCreateState();
}

class _PostCreateState extends State<PostCreate> {
  bool isList = true;

  // Modo Text
  final _textCtrl = TextEditingController();

  // Modo List (múltiples inputs)
  final List<TextEditingController> _listCtrls = [TextEditingController()];
  final List<FocusNode> _listFocus = [FocusNode()];

  static const Color baseColor = Color(0xFF426FA4);
  static const Color baseColor20 = Color.fromRGBO(66, 111, 164, 0.20);
  static const Color sheetColor = Color.fromARGB(255, 38, 54, 100);

  @override
  void initState() {
    super.initState();
    _textCtrl.addListener(() => setState(() {}));
    for (final c in _listCtrls) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _textCtrl.dispose();
    for (final c in _listCtrls) c.dispose();
    for (final f in _listFocus) f.dispose();
    super.dispose();
  }

  bool _listHasContent() =>
      _listCtrls.any((c) => c.text.trim().isNotEmpty);

  void _addListField({int? afterIndex}) {
    setState(() {
      final ctrl = TextEditingController();
      final node = FocusNode();
      // escuchar cambios para habilitar/deshabilitar botón
      ctrl.addListener(() => setState(() {}));

      final insertAt = (afterIndex == null)
          ? _listCtrls.length
          : (afterIndex + 1);

      _listCtrls.insert(insertAt, ctrl);
      _listFocus.insert(insertAt, node);

      // mover el foco al nuevo input
      Future.microtask(() {
        FocusScope.of(context).requestFocus(node);
      });
    });
  }

  void _removeListField(int index) {
    if (_listCtrls.length == 1) {
      // Siempre mantener al menos 1 campo
      _listCtrls.first.clear();
      return;
    }
    setState(() {
      _listCtrls[index].dispose();
      _listFocus[index].dispose();
      _listCtrls.removeAt(index);
      _listFocus.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final canPost = isList ? _listHasContent() : _textCtrl.text.trim().isNotEmpty;

    return Container(
      height: 600,
      decoration: const BoxDecoration(
        color: sheetColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 56, height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Título + ayuda
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Create your sleep post',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.20),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.help_outline),
                    color: Colors.white,
                    tooltip: 'Help',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Toggle List / Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pillButton(
                  label: 'List',
                  selected: isList,
                  onTap: () {
                    setState(() {
                      isList = true;
                      _textCtrl.clear();
                      if (_listCtrls.isEmpty) _addListField();
                    });
                  },
                ),
                const SizedBox(width: 12),
                _pillButton(
                  label: 'Text',
                  selected: !isList,
                  onTap: () {
                    setState(() {
                      isList = false;
                      _textCtrl.clear();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Contenido
            if (isList) ...[
              Expanded(child: _listInputs()),
            ] else ...[
              _textArea(),
              const Spacer(),
            ],

            // Botón inferior
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: canPost ? () {
                  // TODO: enviar
                  // final items = _listCtrls.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList();
                  // final text = _textCtrl.text.trim();
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: canPost ? baseColor : baseColor20,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text('Post your habit', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Botón estilo píldora
  Widget _pillButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? baseColor : baseColor20,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        shape: const StadiumBorder(),
      ),
      child: Text(label),
    );
  }

  // Lista de inputs (cada Enter crea uno nuevo)
  Widget _listInputs() {
    return ListView.separated(
      itemCount: _listCtrls.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.10),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.20),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.check_circle, color: Colors.white70, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _listCtrls[i],
                  focusNode: _listFocus[i],
                  onSubmitted: (_) => _addListField(afterIndex: i), // 👈 ENTER crea otro input
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Type your best sleep habit...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.15),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Borrar
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                tooltip: 'Remove',
                onPressed: () => _removeListField(i),
              ),
            ],
          ),
        );
      },
    );
  }

  // Modo Text: textarea
  Widget _textArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _textCtrl,
        minLines: 6,
        maxLines: 6,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Type your best sleep habit...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
