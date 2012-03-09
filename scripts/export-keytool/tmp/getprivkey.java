import java.security.cert.Certificate;
import java.security.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.BufferedInputStream;

class getprivkey {

public static void main (String[] args) { 
	try {
	KeyStore ks = KeyStore.getInstance("JKS");
    FileInputStream ksfis = new FileInputStream(args[0]); 
    BufferedInputStream ksbufin = new BufferedInputStream(ksfis);  
	
	String alias = "espcp1-cc";
	char pass[] = new char[8];
	pass[0] = 'p';
	pass[1] = '@';
	pass[2] = 's';
	pass[3] = 's';
	pass[4] = 'w';
	pass[5] = '0';
	pass[6] = 'r';
	pass[7] = 'd';

	ks.load(ksbufin, pass);

	    PrivateKey priv = (PrivateKey) ks.getKey(alias, pass);
	System.out.println(priv.getFormat().toString());
	} catch (Exception e) { 
	e.printStackTrace();
	}
}
}
