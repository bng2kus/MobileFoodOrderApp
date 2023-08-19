class Order{
  final String _flavor;
  final String _size;
  final String _cost;

  Order(this._flavor, this._size, this._cost);

  @override
  String toString(){
    return 'Flavor: $_flavor \n' + 'Size: $_size \n' + 'Cost: $_cost';
  }

}