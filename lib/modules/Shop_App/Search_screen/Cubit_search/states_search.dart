 abstract  class SearchState{}
 class SearchIntialState extends SearchState{}
 class SearchLoadingState extends SearchState{}
 class SearchSucessState extends SearchState{}
 class SearchErorrState extends SearchState{
  final String ? erorr;

  SearchErorrState(this.erorr);
}
