class ProtectedResource {
    private Resource theResource = ...;
    private String[] allowedUsers = ...;
    public String[] getAllowedUsers () {
	return allowedUsers;                   ---> return a copy of allowedUsers to avoid mutation of the original data
    }
    public String currentUser() {...}
    public void useTheResource() {
	for(int i=0; i < allowedUsers.length; i++) {
	    if(currentUser().equals(allowedUsers[i])) {
	    ... // access allowed: use it
	    return;
	}
    }
	   throw new IllegalAccessException();
    }
}
