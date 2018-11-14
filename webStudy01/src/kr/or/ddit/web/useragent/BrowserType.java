package kr.or.ddit.web.useragent;

public enum BrowserType {
	CHROME("크롬"), FIREFOX("파이어폭스"), TRIDENT("익스플로러"), OTHER("기타");
	
	private String browserName;
	
	BrowserType(String browserName){
		this.browserName = browserName;
	}
	
	public String getBrowserName() {
		return browserName;
	}
	
	public static BrowserType getBrowerType(String userAgent) {
		BrowserType browserType = BrowserType.OTHER;
		BrowserType[] browserTypes = BrowserType.values();
		for(BrowserType temp : browserTypes) {
			if (userAgent.toUpperCase().contains(temp.name())) {
				browserType = temp;
				break;
			}
		}
		return browserType;
	}
	
}
