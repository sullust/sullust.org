import java.io.FileInputStream;
import java.security.KeyStore;
import java.security.Key;
 
public class DumpPrivateKey {
        static public void main(String[] args) {
                try {
                        KeyStore ks = KeyStore.getInstance("jks");
                        ks.load(new FileInputStream("espcp1-cc.jks"),
                                 "p@ssw0rd".toCharArray());
                        Key key = ks.getKey("espcp1-cc",
                                 "p@ssw0rd".toCharArray());
                        System.out.write(key.getEncoded());
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }
}

