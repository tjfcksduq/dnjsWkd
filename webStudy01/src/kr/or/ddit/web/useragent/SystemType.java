package kr.or.ddit.web.useragent;

public enum SystemType {
	DESKTOP(new String[] {"windows nt", "linux"}, "데스크탑"),
	MOBILE(new String[] {"android", "iphone"}, "모바일"),
	OTHER(new String[] {}, "기타");
	
	private String[] keywords;
	private String systemName;
	
	private SystemType(String[] keywords, String systemName) {
		this.keywords = keywords;
		this.systemName = systemName;
	}

	public String getSystemName() {
		return this.systemName;
	}
	
	public boolean matches(String userAgent) {
		boolean result = false;
		userAgent = userAgent.toLowerCase();
		for (String keyword : keywords) {
			result = userAgent.contains(keyword);
			if (result) break;
		}
		return result;
	}
	
	public static SystemType getSystemType(String userAgent) {
		SystemType systemType = SystemType.OTHER;
		SystemType[] systemTypes = SystemType.values();
		for (SystemType temp : systemTypes) {
			if (temp.matches(userAgent)) {
				systemType = temp;
				break;
			}
		}
		return systemType;
	}
	
}
