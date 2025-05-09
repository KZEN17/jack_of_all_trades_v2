import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jack_of_all_trades/config/theme/app_colors.dart';
import 'package:jack_of_all_trades/core/services/storage_service.dart';
import 'package:jack_of_all_trades/providers/user_provider.dart';
import 'package:jack_of_all_trades/widgets/common/custom_button.dart';
import 'package:jack_of_all_trades/widgets/common/custom_text_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  // For handyman registration
  final List<String> _specialties = [];
  final TextEditingController _bioController = TextEditingController();

  // Profile picture
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor:
            userProvider.isClient ? AppColors.primary : AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join as a ${userProvider.isClient ? 'Client' : 'Handyman'}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please fill in your details to create an account',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              _buildProfilePictureSelector(),
              const SizedBox(height: 24),
              CustomTextField(
                label: 'Full Name',
                hint: 'John Doe',
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.person_outline),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'your.email@example.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone Number',
                hint: '+356 9999 9999',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: '********',
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Confirm Password',
                hint: '********',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              // Add handyman specific fields if userType is handyman
              if (userProvider.isHandyman) ...[
                const SizedBox(height: 24),
                Text(
                  'Handyman Details',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildSpecialtiesSelector(),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Bio',
                  hint: 'Tell us about your experience and skills',
                  controller: _bioController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bio';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
              ],
              const SizedBox(height: 24),
              CustomButton(
                label: 'Create Account',
                onPressed: _register,
                isLoading: _isLoading,
                width: double.infinity,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color:
                            userProvider.isClient
                                ? AppColors.primary
                                : AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSelector() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                image:
                    _imageFile != null
                        ? DecorationImage(
                          image: FileImage(
                            //File(_imageFile!.path),
                            // This doesn't work in web
                            // Replace with NetworkImage in real app
                            // Simulating an image for now
                            // Let's create a temporary avatar
                            NetworkImage('https://via.placeholder.com/150')
                                as dynamic,
                          ),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child:
                  _imageFile == null
                      ? Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Colors.grey[400],
                      )
                      : null,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: _pickImage,
            child: Text(
              _imageFile == null ? 'Add Profile Picture' : 'Change Picture',
              style: TextStyle(
                color:
                    Provider.of<UserProvider>(context).isClient
                        ? AppColors.primary
                        : AppColors.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Widget _buildSpecialtiesSelector() {
    // List of available specialties
    final availableSpecialties = [
      'Cleaning',
      'Electrical',
      'Plumbing',
      'Painting',
      'Carpentry',
      'Gardening',
      'Moving',
      'Assembly',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialties',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              availableSpecialties.map((specialty) {
                final isSelected = _specialties.contains(specialty);
                return FilterChip(
                  label: Text(specialty),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _specialties.add(specialty);
                      } else {
                        _specialties.remove(specialty);
                      }
                    });
                  },
                  selectedColor: AppColors.secondary.withOpacity(0.2),
                  checkmarkColor: AppColors.secondary,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: isSelected ? AppColors.secondary : AppColors.border,
                  ),
                );
              }).toList(),
        ),
        if (_specialties.isEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Please select at least one specialty',
            style: TextStyle(color: AppColors.error, fontSize: 12),
          ),
        ],
      ],
    );
  }

  Future<void> _register() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Validate specialties if handyman
    if (userProvider.isHandyman && _specialties.isEmpty) {
      setState(() {}); // Trigger rebuild to show error
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Mock registration delay
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      final storageService = Provider.of<StorageService>(
        context,
        listen: false,
      );

      // Mock user data for storage
      final userData = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'userType': userProvider.userType,
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      // // Add handyman specific data if needed
      // if (userProvider.isHandyman) {
      //   userData['specialties'] = _specialties;
      //   userData['bio'] = _bioController.text;
      //   userData['rating'] = 0.0;
      //   userData['completedJobs'] = 0;
      // }

      await storageService.saveUserData(userData);
      await storageService.setAuthToken(
        'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (context.mounted) {
        if (userProvider.isClient) {
          context.go('/client/home');
        } else {
          context.go('/handyman/home');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
