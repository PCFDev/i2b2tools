import java.net.*;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

public final class UpdateCells {

	private UpdateCells() { }

	public static void main(final String[] args) {
		try {
			final UpdateCells db = new UpdateCells();

			final InetAddress addr = db.getLocalHost();

			// Get IP Address
			final String ipAddr = addr.getHostAddress();

			// Get hostname
			final String hostname = addr.getHostName();

			System.out.println("Welcome to i2b2 Vmware 1.7");
			System.out.println(" ");
			System.out.println("All passwords are demouser");
			System.out.println(" ");
			System.out.println("To use this i2b2 server 1.7 instance with one of the following:");
			System.out.println(" ");
			System.out.println("1) webclient");
			System.out.println("   Open a browser on another system and go to the following address:");
			System.out.println("   http://" + ipAddr + "/");
			System.out.println(" ");
			System.out.println("2) admin");
			System.out.println("   Open a browser on another system and go to the following address:");
			System.out.println("   http://" + ipAddr + "/admin");
			System.out.println(" ");
			System.out.println("3) i2b2 Workbench");
			System.out.println("   Copy the following text into the properties file (i2b2workbench.properties)");
			System.out.println("   I2b2.1=i2b2demo,REST,http://" + ipAddr + "/i2b2/services/PMService/");
			System.out.println(" ");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public InetAddress getLocalHost(final InetAddress intendedDestination) throws SocketException {
		final int port = 8888;

		final DatagramSocket sock = new DatagramSocket(port);

		sock.connect(intendedDestination, port);

		try {
			return sock.getLocalAddress();
		} finally {
			try {
				sock.disconnect();
			} catch (Exception e) { }

			try {
				sock.close();
			} catch (Exception e) { }
		}
	}

	/**
	 * Returns an InetAddress representing the address of the localhost. Every
	 * attempt is made to find an address for this host that is not the loopback
	 * address. If no other address can be found, the loopback will be returned.
	 * 
	 * @return InetAddress - the address of localhost
	 * @throws UnknownHostException
	 *             - if there is a problem determing the address
	 */
	public InetAddress getLocalHost() throws UnknownHostException {
		final InetAddress localHost = InetAddress.getLocalHost();
		
		System.out.println("Checking if lookback");
		
		if (!localHost.isLoopbackAddress()) {
			return localHost;
		}
		
		System.out.println("Getting address last one was lookback");
		
		final InetAddress[] addrs = getAllLocalUsingNetworkInterface();
		
		for (int i = 0; i < addrs.length; i++) {
			System.out.println("Found " + addrs[i].getHostAddress());
			if (addrs[i].getAddress().length == 4) {
				if (!addrs[i].isLoopbackAddress()) {
					return addrs[i];
				}
			}
		}
		
		System.out.println("Found " + localHost.getHostAddress());
		
		return localHost;
	}

	/**
	 * This method attempts to find all InetAddresses for this machine in a
	 * conventional way (via InetAddress). If only one address is found and it
	 * is the loopback, an attempt is made to determine the addresses for this
	 * machine using NetworkInterface.
	 * 
	 * @return InetAddress[] - all addresses assigned to the local machine
	 * @throws UnknownHostException
	 *             - if there is a problem determining addresses
	 */
	public InetAddress[] getAllLocal() throws UnknownHostException {
		final InetAddress[] iAddresses = InetAddress.getAllByName("127.0.0.1");
		
		if (iAddresses.length != 1) {
			return iAddresses;
		}
		
		if (!iAddresses[0].isLoopbackAddress()) {
			return iAddresses;
		}
		
		return getAllLocalUsingNetworkInterface();

	}

	/**
	 * Utility method that delegates to the methods of NetworkInterface to
	 * determine addresses for this machine.
	 * 
	 * @return InetAddress[] - all addresses found from the NetworkInterfaces
	 * @throws UnknownHostException
	 *             - if there is a problem determining addresses
	 */
	private InetAddress[] getAllLocalUsingNetworkInterface() throws UnknownHostException {
		final ArrayList<InetAddress> addresses = new ArrayList<InetAddress>();
		
		Enumeration<NetworkInterface> e = null;
		
		try {
			e = NetworkInterface.getNetworkInterfaces();
		} catch (SocketException ex) {
			throw new UnknownHostException("127.0.0.1");
		}
		
		while (e.hasMoreElements()) {
			final NetworkInterface ni = e.nextElement();
			
			for (final Enumeration<InetAddress> e2 = ni.getInetAddresses(); e2.hasMoreElements();) {
				addresses.add(e2.nextElement());
			}
		}
		
		return addresses.toArray(new InetAddress[addresses.size()]);
	}
}
