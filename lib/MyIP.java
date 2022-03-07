import java.net.*;

class MyIP{
    public static void main(String args[]) throws Exception{
        try{
InetAddressipo = InetAddress.getLocalHost();
System.out.println("Host Name: " + ipo.getHostName());
System.out.println("IP Address: " + ipo.getHostAddress());
            }
        catch(Exception e){
System.out.println("Some ERROR occured...");
            }
    }
}
