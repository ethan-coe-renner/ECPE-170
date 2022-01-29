#!/usr/bin/env python3

# Python DNS query client
#
# Example usage:
#   ./dns.py --type=A --name=www.pacific.edu --server=8.8.8.8
#   ./dns.py --type=AAAA --name=www.google.com --server=8.8.8.8

# Should provide equivalent results to:
#   dig www.pacific.edu A @8.8.8.8 +noedns
#   dig www.google.com AAAA @8.8.8.8 +noedns
#   (note that the +noedns option is used to disable the pseduo-OPT
#    header that dig adds. Our Python DNS client does not need
#    to produce that optional, more modern header)


# from dns_tools import dns, dns_header_bitfields  # Custom module for boilerplate code

import argparse
import ctypes
import random
import socket
import struct
import sys

def main():

    # Setup configuration
    parser = argparse.ArgumentParser(description='DNS client for ECPE 170')
    parser.add_argument('--type', action='store', dest='qtype',
                        required=True, help='Query Type (A or AAAA)')
    parser.add_argument('--name', action='store', dest='qname',
                        required=True, help='Query Name')
    parser.add_argument('--server', action='store', dest='server_ip',
                        required=True, help='DNS Server IP')

    args = parser.parse_args()
    qtype = args.qtype
    qname = args.qname
    server_ip = args.server_ip
    port = 3456
    server_address = (server_ip, port)

    if qtype not in ("A", "AAAA"):
        print("Error: Query Type must be 'A' (IPv4) or 'AAAA' (IPv6)")
        sys.exit()

    # Create UDP socket
    # ---------
    # STUDENT TO-DO
    # ---------

    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


    # Generate DNS request message
    # ---------
    # STUDENT TO-DO
    # ---------

    message = bytearray()
    message += struct.pack("B",1) # MessageID

    message += struct.pack("!L",10) # MessageID
    message += struct.pack("!L",12) # MessageID

    message += struct.pack("!L",5) # MessageID

    message += struct.pack("B",69) # MessageID
    message += struct.pack("B",84) # MessageID
    message += struct.pack("B",72) # MessageID
    message += struct.pack("B",65) # MessageID
    message += struct.pack("B",78) # MessageID


    # Send request message to server
    # (Tip: Use sendto() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------

    bytes_sent = s.sendto(message, server_address)


    # Receive message from server
    # (Tip: use recvfrom() function for UDP)
    # ---------
    # STUDENT TO-DO
    # ---------

    max_bytes = 4096
    (raw_bytes, src_addr) = s.recvfrom(max_bytes)


    # Close socket
    # ---------
    # STUDENT TO-DO
    # ---------

    s.close()


    unpacked = struct.unpack('!bhl',raw_bytes)
    print(unpacked)
    statcode = unpacked[1]
    summation = unpacked[2]

    if statcode == 1:
        print("success, 10 + 12 = ", summation)
    else:
        print("failure")


if __name__ == "__main__":
    sys.exit(main())


