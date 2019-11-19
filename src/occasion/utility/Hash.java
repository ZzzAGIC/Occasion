package occasion.utility;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class Hash {
	
	public static byte[] generateHash(char[] password, byte[] salt) {		
		PBEKeySpec spec = new PBEKeySpec(password, salt, 10000, 256);
	     
		try {
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		    return skf.generateSecret(spec).getEncoded();
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
		      throw new AssertionError("Error while hashing a password: " + e.getMessage(), e); 
		} finally {
			spec.clearPassword();
		}        
	}
	
	public static boolean validateHash(char[] password, byte[] salt, byte[] expectedHash) {
		byte[] pwdHash = generateHash(password, salt);
	    Arrays.fill(password, Character.MIN_VALUE);
	    
	    if (pwdHash.length != expectedHash.length) return false;
	    
	    for (int i = 0; i < pwdHash.length; i++) {
	      if (pwdHash[i] != expectedHash[i]) return false;
	    }
	    return true;
	}
	
	public static byte[] getSalt() throws NoSuchAlgorithmException {
		SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
		
		byte[] salt = new byte[16];
		
		sr.nextBytes(salt);
		
		return salt;
	}
}
