import sys

def extract_data(filename):
    users = []
    hashes = []
    
    with open(filename, 'r') as f:
        for line in f:
            parts = line.strip().split(":")
            
            # Check if the line format is correct
            if len(parts) >= 4:
                users.append(parts[0])
                hashes.append(parts[3])
                
    return users, hashes

def save_to_files(users, hashes):
    with open('users', 'w') as f:
        for user in users:
            f.write(f"{user}\n")

    with open('hashes', 'w') as f:
        for h in hashes:
            f.write(f"{h}\n")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Script to split user and hashes output from Impacket-Secretsdump format is -> user:lt:ntlm::")
        print("Usage: python script_name.py filename")
        sys.exit(1)
    
    filename = sys.argv[1]
    users, hashes = extract_data(filename)
    save_to_files(users, hashes)
