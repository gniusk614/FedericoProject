package paging;

public class SearchCriteria extends Criteria {

	private String searchType;
	private String keyword;
	
	
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		System.out.println("searchType setter:"+searchType);
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		System.out.println("keyword setter:"+keyword);
		this.keyword = keyword;
	}
	
}
