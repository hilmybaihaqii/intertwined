import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'setup_components.dart';

// --- TIPE 1: INPUT TEKS BIASA ---
class StepInputText extends StatelessWidget {
  final String question;
  final String hint;
  final TextEditingController controller;
  final bool isNumber;

  const StepInputText({
    super.key,
    required this.question,
    required this.hint,
    required this.controller,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return StepTemplate(
      title: question,
      content: AestheticTextField(
        controller: controller, 
        hint: hint, 
        isNumber: isNumber
      ),
    );
  }
}

// --- TIPE 2: PILIHAN GENDER (KHUSUS) ---
class StepGender extends StatelessWidget {
  final String selectedGender;
  final Function(String) onSelect;

  const StepGender({
    super.key, 
    required this.selectedGender, 
    required this.onSelect
  });

  @override
  Widget build(BuildContext context) {
    return StepTemplate(
      title: "And\nYou are...",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _GenderCard(
            label: "Girl", 
            icon: Icons.female, 
            isSelected: selectedGender == "Girl", 
            onTap: () => onSelect("Girl")
          ),
          _GenderCard(
            label: "Boy", 
            icon: Icons.male, 
            isSelected: selectedGender == "Boy", 
            onTap: () => onSelect("Boy")
          ),
        ],
      ),
    );
  }
}

// Widget Lokal untuk Kartu Gender
class _GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.label, 
    required this.icon, 
    required this.isSelected, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 120, height: 120,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepBrown : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade200, 
            width: 2.5
          ),
          boxShadow: isSelected 
              ? [
                  BoxShadow(
                    color: AppColors.deepBrown.withValues(alpha: 0.3), 
                    blurRadius: 15, 
                    offset: const Offset(0, 8)
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1), 
                    blurRadius: 5, 
                    offset: const Offset(0, 2)
                  )
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              size: 48, 
              color: isSelected ? Colors.white : Colors.grey[300]
            ),
            const SizedBox(height: 10),
            Text(
              label, 
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400], 
                fontWeight: FontWeight.w900, 
                fontSize: 16
              )
            ),
          ],
        ),
      ),
    );
  }
}

// --- TIPE 3: PILIHAN TANGGAL ---
class StepDate extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const StepDate({
    super.key, 
    required this.selectedDate, 
    required this.onDateSelected
  });

  @override
  Widget build(BuildContext context) {
    return StepTemplate(
      title: "Let's get your\nBirthdate",
      content: Center(
        child: InkWell(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2004), 
              firstDate: DateTime(1990), 
              lastDate: DateTime.now(),
              builder: (ctx, child) => Theme(
                data: Theme.of(ctx).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: AppColors.deepBrown, 
                    onPrimary: Colors.white, 
                    onSurface: AppColors.deepBrown
                  )
                ), 
                child: child!
              ),
            );
            if (picked != null) onDateSelected(picked);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.05), 
                  blurRadius: 10, 
                  offset: const Offset(0, 5)
                )
              ]
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cake_rounded, 
                  color: AppColors.deepBrown, 
                  size: 28
                ),
                const SizedBox(width: 16),
                Text(
                  selectedDate == null 
                    ? "Select Date" 
                    : "${selectedDate!.day} / ${selectedDate!.month} / ${selectedDate!.year}",
                  style: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w800, 
                    color: AppColors.deepBrown
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

// --- TIPE 4: SINGLE OPTION (Misal: Golongan Darah) ---
class StepOptions extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelect;

  const StepOptions({
    super.key, 
    required this.title, 
    required this.options, 
    required this.selectedOption, 
    required this.onSelect
  });

  @override
  Widget build(BuildContext context) {
    return StepTemplate(
      title: title,
      content: Wrap(
        spacing: 12, 
        runSpacing: 12, 
        alignment: WrapAlignment.start,
        children: options.map((opt) => BouncyOptionCard(
          label: opt, 
          isSelected: selectedOption == opt, 
          onTap: () => onSelect(opt)
        )).toList(),
      ),
    );
  }
}

// --- TIPE 5: MULTI SELECT OPTION (Misal: Hobi) ---
class StepMultiOptions extends StatelessWidget {
  final String title;
  final List<String> options;
  final List<String> selectedOptions;
  final Function(String) onSelect;

  const StepMultiOptions({
    super.key, 
    required this.title, 
    required this.options, 
    required this.selectedOptions, 
    required this.onSelect
  });

  @override
  Widget build(BuildContext context) {
    return StepTemplate(
      title: title,
      content: Wrap(
        spacing: 12, 
        runSpacing: 12, 
        alignment: WrapAlignment.start,
        children: options.map((opt) => BouncyOptionCard(
          label: opt, 
          isSelected: selectedOptions.contains(opt), // Cek apakah ada di list
          onTap: () => onSelect(opt)
        )).toList(),
      ),
    );
  }
}