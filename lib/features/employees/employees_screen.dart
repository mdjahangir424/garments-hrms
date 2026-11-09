
import 'package:flutter/material.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  static const Color primary = Color(0xFF2563EB);

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, String>> employees = [
    {
      'id': 'EMP-001',
      'name': 'Rahim Ahmed',
      'department': 'Sewing',
      'designation': 'Operator',
      'status': 'Active',
    },
    {
      'id': 'EMP-002',
      'name': 'Nusrat Jahan',
      'department': 'Quality',
      'designation': 'Quality Inspector',
      'status': 'Active',
    },
    {
      'id': 'EMP-003',
      'name': 'Karim Uddin',
      'department': 'Finishing',
      'designation': 'Supervisor',
      'status': 'Inactive',
    },
  ];

  String selectedFilter = 'All';
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // ADD EMPLOYEE
  Future<void> _showAddEmployeeDialog() async {
    final formKey = GlobalKey<FormState>();

    final idController = TextEditingController();
    final nameController = TextEditingController();
    final departmentController = TextEditingController();
    final designationController = TextEditingController();

    String newStatus = 'Active';

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Add New Employee',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),
              content: SizedBox(
                width: 420,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _formField(
                          controller: idController,
                          label: 'Employee ID',
                          hint: 'Example: EMP-004',
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: nameController,
                          label: 'Full Name',
                          hint: 'Enter employee name',
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: departmentController,
                          label: 'Department',
                          hint: 'Example: Sewing',
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: designationController,
                          label: 'Designation',
                          hint: 'Example: Operator',
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          value: newStatus,
                          decoration: const InputDecoration(
                            labelText: 'Employee Status',
                            border: OutlineInputBorder(),
                          ),
                          items: ['Active', 'Inactive']
                              .map(
                                (status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                newStatus = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final employeeId = idController.text.trim();

                    final duplicate = employees.any(
                      (employee) =>
                          employee['id']!.toLowerCase() ==
                          employeeId.toLowerCase(),
                    );

                    if (duplicate) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'This Employee ID already exists.',
                          ),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      employees.add({
                        'id': employeeId,
                        'name': nameController.text.trim(),
                        'department':
                            departmentController.text.trim(),
                        'designation':
                            designationController.text.trim(),
                        'status': newStatus,
                      });

                      searchController.clear();
                      searchQuery = '';
                      selectedFilter = 'All';
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Employee added successfully (Demo only).',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Employee'),
                ),
              ],
            );
          },
        );
      },
    );

    idController.dispose();
    nameController.dispose();
    departmentController.dispose();
    designationController.dispose();
  }

  // EMPLOYEE DETAILS
  Future<void> _showEmployeeDetails(
    Map<String, String> employee,
  ) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Employee Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF172554),
            ),
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailRow('Employee ID', employee['id']!),
                _detailRow('Full Name', employee['name']!),
                _detailRow('Department', employee['department']!),
                _detailRow('Designation', employee['designation']!),
                _detailRow('Status', employee['status']!),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF172554),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // EDIT EMPLOYEE
  Future<void> _showEditEmployeeDialog(
    Map<String, String> employee,
  ) async {
    final employeeIndex = employees.indexOf(employee);

    if (employeeIndex == -1) return;

    final formKey = GlobalKey<FormState>();

    final idController =
        TextEditingController(text: employee['id']);
    final nameController =
        TextEditingController(text: employee['name']);
    final departmentController =
        TextEditingController(text: employee['department']);
    final designationController =
        TextEditingController(text: employee['designation']);

    String editedStatus = employee['status']!;

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text(
                'Edit Employee',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),
              content: SizedBox(
                width: 420,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _formField(
                          controller: idController,
                          label: 'Employee ID',
                          hint: 'Enter employee ID',
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: nameController,
                          label: 'Full Name',
                          hint: 'Enter employee name',
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: departmentController,
                          label: 'Department',
                          hint: 'Enter department',
                        ),
                        const SizedBox(height: 14),
                        _formField(
                          controller: designationController,
                          label: 'Designation',
                          hint: 'Enter designation',
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          value: editedStatus,
                          decoration: const InputDecoration(
                            labelText: 'Employee Status',
                            border: OutlineInputBorder(),
                          ),
                          items: ['Active', 'Inactive']
                              .map(
                                (status) => DropdownMenuItem(
                                  value: status,
                                  child: Text(status),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() {
                                editedStatus = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final editedId = idController.text.trim();

                    final duplicate = employees.asMap().entries.any(
                      (entry) =>
                          entry.key != employeeIndex &&
                          entry.value['id']!.toLowerCase() ==
                              editedId.toLowerCase(),
                    );

                    if (duplicate) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'This Employee ID already exists.',
                          ),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      employees[employeeIndex] = {
                        'id': editedId,
                        'name': nameController.text.trim(),
                        'department':
                            departmentController.text.trim(),
                        'designation':
                            designationController.text.trim(),
                        'status': editedStatus,
                      };
                    });

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Employee updated successfully (Demo only).',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Update Employee'),
                ),
              ],
            );
          },
        );
      },
    );

    idController.dispose();
    nameController.dispose();
    departmentController.dispose();
    designationController.dispose();
  }

  // DELETE EMPLOYEE
  void _deleteEmployee(Map<String, String> employee) {
    setState(() {
      employees.remove(employee);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Employee deleted successfully (Demo only).'),
      ),
    );
  }

  // DELETE CONFIRMATION DIALOG
  Future<void> _confirmDeleteEmployee(
    Map<String, String> employee,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Employee?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF172554),
            ),
          ),
          content: Text(
            'Are you sure you want to delete '
            '${employee['name']} (${employee['id']})?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      _deleteEmployee(employee);
    }
  }

  // FORM FIELD
  Widget _formField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  // MAIN SCREEN
  @override
  Widget build(BuildContext context) {
    final filteredEmployees = employees.where((employee) {
      final matchesStatus = selectedFilter == 'All' ||
          employee['status'] == selectedFilter;

      final query = searchQuery.toLowerCase();

      final matchesSearch =
          employee['name']!.toLowerCase().contains(query) ||
          employee['id']!.toLowerCase().contains(query) ||
          employee['department']!.toLowerCase().contains(query) ||
          employee['designation']!.toLowerCase().contains(query);

      return matchesStatus && matchesSearch;
    }).toList();

    final activeCount =
        employees.where((e) => e['status'] == 'Active').length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Employees',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172554),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Manage your workforce and employee information.',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 24),

            LayoutBuilder(
              builder: (context, constraints) {
                final columns =
                    constraints.maxWidth > 600 ? 2 : 1;

                return GridView.count(
                  crossAxisCount: columns,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: columns == 1 ? 3.2 : 2.5,
                  children: [
                    _summaryCard(
                      'Total Employees',
                      '${employees.length}',
                      Icons.groups_rounded,
                      primary,
                    ),
                    _summaryCard(
                      'Active Employees',
                      '$activeCount',
                      Icons.verified_user_rounded,
                      const Color(0xFF16A34A),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: const Color(0xFFE8EDF5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: 12,
                    spacing: 12,
                    children: [
                      const Text(
                        'Employee List',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF172554),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _showAddEmployeeDialog,
                        icon: const Icon(Icons.add, size: 17),
                        label: const Text('Add Employee'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.trim();
                      });
                    },
                    decoration: InputDecoration(
                      hintText:
                          'Search by name, ID, department...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                                setState(() {
                                  searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: selectedFilter,
                    decoration: const InputDecoration(
                      labelText: 'Employee Status',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    items: ['All', 'Active', 'Inactive']
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedFilter = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 16),

                  if (filteredEmployees.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Text(
                          'No employees found',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )
                  else
                    ...filteredEmployees.map(_employeeCard),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SUMMARY CARD
  Widget _summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // EMPLOYEE CARD
  Widget _employeeCard(Map<String, String> employee) {
    final isActive = employee['status'] == 'Active';

    final initials = employee['name']!
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => part[0])
        .take(2)
        .join();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE8EDF5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFFDBEAFE),
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${employee['id']} • ${employee['department']}',
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      employee['designation']!,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  employee['status']!,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF15803D)
                        : const Color(0xFF64748B),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // DETAILS, EDIT AND DELETE BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      _showEmployeeDetails(employee),
                  icon: const Icon(
                    Icons.visibility_outlined,
                    size: 15,
                  ),
                  label: const Text(
                    'Details',
                    style: TextStyle(fontSize: 10),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primary,
                    side: const BorderSide(color: primary),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _showEditEmployeeDialog(employee),
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 15,
                  ),
                  label: const Text(
                    'Edit',
                    style: TextStyle(fontSize: 10),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _confirmDeleteEmployee(employee),
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 15,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 10),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
