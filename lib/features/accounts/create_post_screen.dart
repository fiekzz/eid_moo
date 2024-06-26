import 'package:eid_moo/shared/components/em_button.dart';
import 'package:eid_moo/shared/components/em_fetch.dart';
import 'package:eid_moo/shared/utils/theme/em_theme.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    super.key,
    required this.masjidId,
  });

  final String masjidId;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController? _descriptionController = TextEditingController();
  TextEditingController? _priceController = TextEditingController();
  TextEditingController? _partsController = TextEditingController();

  FocusNode? _descriptionFocusNode;
  FocusNode? _priceFocusNode;
  FocusNode? _partsFocusNode;

  bool _isLoading = false;

  Future<void> _createPost() async {
    try {
      if (_descriptionController!.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Description is required'),
          ),
        );

        return;
      }

      if (_priceController!.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Price is required'),
          ),
        );

        return;
      }

      if (_partsController!.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Parts is required'),
          ),
        );

        return;
      }

      final response = await EMFetch(
        '/masjid/posts/create',
        method: EMFetchMethod.POST,
        body: {
          'description': _descriptionController!.text,
          'price': int.tryParse(_priceController!.text),
          'parts': int.tryParse(_partsController!.text),
          'masjidId': widget.masjidId,
        },
      ).authorizedRequest();

      if (response['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Post created successfully'),
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred!'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred!'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _descriptionController = TextEditingController();
    _priceController = TextEditingController();
    _partsController = TextEditingController();
    _partsFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _descriptionFocusNode!.unfocus();
        _priceFocusNode!.unfocus();
        _partsFocusNode!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 30,
          ),
          child: SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Form(
              child: Column(
                children: [
                  TextField(
                    focusNode: _descriptionFocusNode,
                    controller: _descriptionController,
                    maxLines: null,
                    maxLength: 20,
                    minLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: EidMooTheme.primaryVariant,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    focusNode: _priceFocusNode,
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: EidMooTheme.primaryVariant,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    focusNode: _partsFocusNode,
                    keyboardType: TextInputType.number,
                    controller: _partsController,
                    decoration: InputDecoration(
                      labelText: 'Parts',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: EidMooTheme.primaryVariant,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.maxFinite,
                    child: EMButton(
                      isLoading: _isLoading,
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await _createPost();
                      },
                      child: const Text('Create Post'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
