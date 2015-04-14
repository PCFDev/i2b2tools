import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public final class I2b2PasswordCryptor {
	public static String toHex(byte[] digest) {
		final StringBuffer buf = new StringBuffer();

		for (int i = 0; i < digest.length; i++) {
			buf.append(Integer.toHexString((int) digest[i] & 0x00FF));
		}

		return buf.toString();
	}

	public static String getHashedPassword(String pass) throws Exception {
		try {
			final MessageDigest md5 = MessageDigest.getInstance("MD5");

			md5.update(pass.getBytes());

			return toHex(md5.digest());
		} catch (NoSuchAlgorithmException e) {
			System.err.println("No such algorithm MD5!");

			System.exit(-1);
		}

		return null;
	}

	public static void main(String[] args) throws Exception {
		if (args.length != 1) {
			System.err.println("Usage: java I2b2PasswordCryptor <plaintext password>");

			System.exit(-1);
		}

		System.out.println(getHashedPassword(args[0]));
	}
}
