import io.jsonwebtoken.security.Keys;
import java.util.Base64;

public class GenerateSecretKey {
    public static void main(String[] args) {
        String secretKey = Base64.getEncoder().encodeToString(Keys.secretKeyFor(io.jsonwebtoken.SignatureAlgorithm.HS256).getEncoded());
        System.out.println("Generated Secret Key: " + secretKey);
    }
}
