import 'package:flutter/material.dart';
import '../widgets/service_card.dart';
import '../widgets/bottom_nav_bar.dart';
import '../services/filter_search_service.dart';
import '../models/service_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _filterSearchService = FilterSearchService();
  List<Service> _services = [];
  bool _isLoading = true;
  String _searchQuery = '';
  double _minPrice = 0.0;
  double _maxPrice = 1000.0;
  double _minRating = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    setState(() {
      _isLoading = true;
    });
    _services = await _filterSearchService.filterAndSearchServices(
      searchQuery: _searchQuery,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
      minRating: _minRating,
    );
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        backgroundColor: Colors.orange[300],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: ServiceSearchDelegate(
                  onQueryUpdate: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                    _fetchServices();
                  },
                ),
              );
              if (result != null) {
                setState(() {
                  _searchQuery = result;
                });
                _fetchServices();
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _services.length,
              itemBuilder: (context, index) {
                final service = _services[index];
                return ServiceCard(
                  title: service.title,
                  description: service.description,
                  price: service.price,
                  rating: service.rating,
                  imageUrl: service.imageUrl,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Show filter dialog
          await showDialog(
            context: context,
            builder: (context) => FilterDialog(
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              minRating: _minRating,
              onApply: (minPrice, maxPrice, minRating) {
                setState(() {
                  _minPrice = minPrice;
                  _maxPrice = maxPrice;
                  _minRating = minRating;
                });
                _fetchServices();
              },
            ),
          );
        },
        child: Icon(Icons.filter_alt),
        backgroundColor: Colors.orange[300],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
