import 'package:flutter/material.dart';

class SimpleDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateSelected;

  const SimpleDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  State<SimpleDatePicker> createState() => _SimpleDatePickerState();
}

class _SimpleDatePickerState extends State<SimpleDatePicker> {
  late DateTime selectedDate;
  late int selectedYear;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    selectedYear = selectedDate.year;
    selectedMonth = selectedDate.month;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 400,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Year and Month Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (selectedMonth > 1) {
                      selectedMonth--;
                    } else {
                      selectedMonth = 12;
                      selectedYear--;
                    }
                    _updateSelectedDate();
                  });
                },
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_getMonthName(selectedMonth)} $selectedYear',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (selectedMonth < 12) {
                      selectedMonth++;
                    } else {
                      selectedMonth = 1;
                      selectedYear++;
                    }
                    _updateSelectedDate();
                  });
                },
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Calendar Grid
          Expanded(
            child: _buildCalendarGrid(),
          ),
          
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onDateSelected(selectedDate);
                  Navigator.of(context).pop();
                },
                child: const Text('Select'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    final firstDayOfMonth = DateTime(selectedYear, selectedMonth, 1).weekday;
    
    List<Widget> dayWidgets = [];
    
    // Add empty cells for days before the first day of the month
    for (int i = 1; i < firstDayOfMonth; i++) {
      dayWidgets.add(const SizedBox(height: 40));
    }
    
    // Add day cells
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(selectedYear, selectedMonth, day);
      final isSelected = date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day;
      final isEnabled = !date.isBefore(widget.firstDate) && !date.isAfter(widget.lastDate);
      
      dayWidgets.add(
        GestureDetector(
          onTap: isEnabled ? () {
            setState(() {
              selectedDate = date;
            });
          } : null,
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : 
                         (isEnabled ? Colors.black : Colors.grey),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }
    
    return GridView.count(
      crossAxisCount: 7,
      children: [
        // Day headers
        const Center(child: Text('S', style: TextStyle(fontWeight: FontWeight.bold))),
        const Center(child: Text('M', style: TextStyle(fontWeight: FontWeight.bold))),
        const Center(child: Text('T', style: TextStyle(fontWeight: FontWeight.bold))),
        const Center(child: Text('W', style: TextStyle(fontWeight: FontWeight.bold))),
        const Center(child: Text('T', style: TextStyle(fontWeight: FontWeight.bold))),
        const Center(child: Text('F', style: TextStyle(fontWeight: FontWeight.bold))),
        const Center(child: Text('S', style: TextStyle(fontWeight: FontWeight.bold))),
        ...dayWidgets,
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _updateSelectedDate() {
    final newDay = selectedDate.day;
    final daysInNewMonth = DateTime(selectedYear, selectedMonth + 1, 0).day;
    final adjustedDay = newDay > daysInNewMonth ? daysInNewMonth : newDay;
    selectedDate = DateTime(selectedYear, selectedMonth, adjustedDay);
  }
}

