import 'package:fidelify_client/models/business/business_models.dart';
import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/utils/toast.dart';
import 'package:flutter/material.dart';


class EditBusinessDataScreen extends StatefulWidget {
  final Business? business;
  final void Function(Business? b)? onFinish;

  const EditBusinessDataScreen({super.key, this.business, this.onFinish});

  void finished(Business? b) {
    if (onFinish != null) {
      onFinish!(b);
    }
  }


  @override
  State<EditBusinessDataScreen> createState() => _EditBusinessDataScreenState();
}

class _EditBusinessDataScreenState extends State<EditBusinessDataScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ApiService api = ApiService.instance;
  late final bool _creating;
  late final BusinessData _bd;
  bool _isLoading = false;
  bool _isAvailableIdentifier = false;
  bool _hasIdentifierBeenModified = false;
  final TextEditingController _identifierController = TextEditingController();

  void _buildIdentifier(String val) {
    if (_hasIdentifierBeenModified) return;
    setState(() {
      _bd.identifier = val
          .trim()
          .toLowerCase()
          .replaceAll(" ", "-")
          .replaceAll(RegExp(r'[^a-z0-9-]'), '');
      _identifierController.text = _bd.identifier ?? '';
    });
  }

  void _checkIdentifierAvailability() {
    //TODO: Implement check availability w/ debouncing
    _isAvailableIdentifier = true;
  }

  void setLoading(bool v) {
    setState(() {
      _isLoading = v;
    });
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setLoading(true);

    final response = _creating
      ? await api.post<Business>(path: "/api/v1/business", data: _bd.toJson(), parser: Business.fromJson)
      : await api.put<Business>(path: "/api/v1/business/${_bd.id}", data: _bd.toJson(), parser: Business.fromJson);

    if (!mounted) return;

    setLoading(false);

    if(response.status == NetworkStatus.error) {
      Toast.error("${response.error!.message} [${response.error!.code}]");
      return;
    }

    widget.finished(response.val);

    Toast.success("Success!");
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // The 'creating' flag is set to true if no business object is received.
    _creating = widget.business == null;
    if (widget.business != null) {
      _bd = BusinessData.fromBusiness(widget.business!);
    } else {
      _bd = BusinessData();
    }

    _identifierController.text = _bd.identifier ?? '';
  }

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // You can now use the 'creating' boolean to conditionally render UI.
    // For example, changing the AppBar title.
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_creating ? "Join Fidelify" : "Edit Business"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Business Name',
                      ),
                      initialValue: _bd.name ?? '',
                      onChanged: _buildIdentifier,
                      onSaved: (value) {
                        _bd.name = value;
                      },
                    ),
                    Column(children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Business identifier',
                                ),
                                controller: _identifierController,
                                onChanged: (_) {
                                  _hasIdentifierBeenModified = true;
                                },
                                validator: (val) {
                                  if (val == null || val.isEmpty || val.length < 3) {
                                    return "Identifier must be at least 3 characters long";
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _bd.identifier = value;
                                },
                              ),
                            ),
                            // const SizedBox(width: 8),
                            // const Icon(Icons.check_circle, color: Colors.green,)
                          ]),
                      const Text(
                          "This will represent a unique identifier for your business"),
                    ],),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                        onPressed: _submit,
                        child: Text(_creating ? "Add your business to Fidelify" : "Save"))
                  ],
                )),
          ),
        ));
  }
}
