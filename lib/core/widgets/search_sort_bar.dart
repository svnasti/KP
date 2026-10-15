import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';

class SearchSortBar extends StatefulWidget {
  const SearchSortBar({
    super.key,
    required this.hint,
    required this.sortOptions,
    required this.selectedSort,
    required this.onChanged,
    required this.onSortSelected,
  });

  final String hint;
  final List<String> sortOptions;
  final int selectedSort;
  final ValueChanged<String> onChanged;
  final ValueChanged<int> onSortSelected;

  @override
  State<SearchSortBar> createState() => _SearchSortBarState();
}

class _SearchSortBarState extends State<SearchSortBar> {
  final _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    setState(() => _showClearButton = value.isNotEmpty);
    widget.onChanged(value.trim());
  }

  void _clear() {
    _controller.clear();
    _handleChanged('');
  }

  @override
  Widget build(BuildContext context) {
    const pillBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      borderSide: BorderSide.none,
    );

    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: _handleChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: AppColors.surfaceGray,
              border: pillBorder,
              enabledBorder: pillBorder,
              focusedBorder: pillBorder,
              prefixIcon: const Icon(Icons.search, color: AppColors.textGray),
              suffixIcon: _showClearButton
                  ? IconButton(
                      tooltip: 'Очистити',
                      icon: const Icon(Icons.close),
                      onPressed: _clear,
                    )
                  : null,
            ),
          ),
        ),
        PopupMenuButton<int>(
          tooltip: 'Сортування',
          initialValue: widget.selectedSort,
          onSelected: widget.onSortSelected,
          itemBuilder: (context) => [
            for (var i = 0; i < widget.sortOptions.length; i++)
              PopupMenuItem<int>(value: i, child: Text(widget.sortOptions[i])),
          ],
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.surfaceGray,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.swap_vert, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }
}
