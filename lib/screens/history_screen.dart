import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../widgets/history_detail_popup.dart';
import '../services/image_storage_service.dart';
import '../models/analysis_history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  List<AnalysisHistory> _historyList = [];
  List<AnalysisHistory> _filteredHistoryList = [];
  bool _isLoading = true;
  String? _errorMessage;
  DateTime _selectedDate = DateTime.now(); // Default to today
  String _filterType = 'hari'; // hari, bulan, tahun

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  /// Public method to refresh history data
  void refreshHistory() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    // Don't show loading if we already have data (for refresh)
    if (_historyList.isEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final history = await ApiService.getHistory();
      if (mounted) {
        setState(() {
          // Sort history by timestamp in descending order (newest first)
          _historyList = history..sort((a, b) => b.timestamp.compareTo(a.timestamp));
          _applyFilter();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _deleteHistoryItem(AnalysisHistory item) async {
    try {
      final success = await ApiService.deleteHistoryItem(item.id);
      if (mounted) {
        if (success) {
          // Remove stored image bytes as well
          await ImageStorageService.removeImage(item.id);
          // Remove from local list
          setState(() {
            _historyList.removeWhere((history) => history.id == item.id);
            _applyFilter();
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data analisis "${item.resultText}" berhasil dihapus'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Gagal menghapus data analisis'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _confirmAndDelete(AnalysisHistory item) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Riwayat Analisis?'),
          content: const Text(
            'Hasil analisa dan gambar terkait akan dihapus permanen dari perangkat dan riwayat. Lanjutkan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      await _deleteHistoryItem(item);
    }
  }

  void _applyFilter() {
    setState(() {
      _filteredHistoryList = _historyList.where((item) {
        final itemDate = item.timestamp;
        
        switch (_filterType) {
          case 'hari':
            return itemDate.year == _selectedDate.year &&
                   itemDate.month == _selectedDate.month &&
                   itemDate.day == _selectedDate.day;
          case 'bulan':
            return itemDate.year == _selectedDate.year &&
                   itemDate.month == _selectedDate.month;
          case 'tahun':
            return itemDate.year == _selectedDate.year;
          default:
            return true;
        }
      }).toList();
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      locale: const Locale('id', 'ID'),
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _applyFilter();
      });
    }
  }

  void _changeFilterType(String type) {
    setState(() {
      _filterType = type;
      _applyFilter();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filter Riwayat'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter berdasarkan:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Hari'),
                          value: 'hari',
                          groupValue: _filterType,
                          onChanged: (String? value) {
                            setDialogState(() {
                              _filterType = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Bulan'),
                          value: 'bulan',
                          groupValue: _filterType,
                          onChanged: (String? value) {
                            setDialogState(() {
                              _filterType = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('Tahun'),
                          value: 'tahun',
                          groupValue: _filterType,
                          onChanged: (String? value) {
                            setDialogState(() {
                              _filterType = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tanggal:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => _selectDate(),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 8),
                          Text(
                            _getFormattedDate(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hasil ditemukan: ${_filteredHistoryList.length} item',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _applyFilter();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Terapkan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _getFormattedDate() {
    switch (_filterType) {
      case 'hari':
        return DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate);
      case 'bulan':
        return DateFormat('MMMM yyyy', 'id_ID').format(_selectedDate);
      case 'tahun':
        return DateFormat('yyyy', 'id_ID').format(_selectedDate);
      default:
        return DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate);
    }
  }

  String _getFilterDescription() {
    switch (_filterType) {
      case 'hari':
        return DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate);
      case 'bulan':
        return DateFormat('MMMM yyyy', 'id_ID').format(_selectedDate);
      case 'tahun':
        return DateFormat('yyyy', 'id_ID').format(_selectedDate);
      default:
        return DateFormat('dd MMMM yyyy', 'id_ID').format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Riwayat Analisis',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (_isLoading && _historyList.isNotEmpty) ...[
              const SizedBox(width: 8),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ],
        ),
        backgroundColor: const Color(0xFFE91E63),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE91E63),
                Color(0xFFAD1457),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterDialog,
            tooltip: 'Filter Tanggal',
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadHistory,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat riwayat...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadHistory,
              child: const Text('Coba Lagi'),
            ),
          ],
        ),
      );
    }

    if (_historyList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Theme.of(context).primaryColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Belum Ada Riwayat',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Lakukan analisis pertama Anda untuk melihat riwayat di sini',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadHistory,
      child: Column(
        children: [
          // Filter Information
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Menampilkan ${_filteredHistoryList.length} dari ${_historyList.length} riwayat - ${_getFilterDescription()}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // History List
          Expanded(
            child: _filteredHistoryList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak Ada Data',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tidak ada riwayat analisis pada ${_getFilterDescription()}',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredHistoryList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredHistoryList[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: item.isCancer 
                                ? Theme.of(context).colorScheme.error 
                                : Theme.of(context).colorScheme.primary,
                            child: Icon(
                              item.isCancer ? Icons.warning : Icons.check_circle,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(item.resultText),
                          subtitle: Text('Confidence: ${item.confidenceText}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${item.timestamp.day}/${item.timestamp.month}/${item.timestamp.year}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                tooltip: 'Hapus',
                                icon: const Icon(Icons.delete_outline, color: Colors.red),
                                onPressed: () => _confirmAndDelete(item),
                              ),
                            ],
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => HistoryDetailPopup(
                                historyItem: item,
                                onDelete: () => _confirmAndDelete(item),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}