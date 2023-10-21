import argparse

def split_user_password(input_file):
    users_output_file = "users.txt"
    passwords_output_file = "passwords.txt"
    
    with open(input_file, 'r') as f:
        lines = f.readlines()

    users = []
    passwords = []

    for line in lines:
        parts = line.strip().split(":")
        if len(parts) == 2:
            users.append(parts[0])
            passwords.append(parts[1])

    with open(users_output_file, 'w') as uf:
        for user in users:
            uf.write(user + '\n')

    with open(passwords_output_file, 'w') as pf:
        for password in passwords:
            pf.write(password + '\n')

    print(f"Processed {len(users)} entries.")
    print(f"Users saved to {users_output_file}")
    print(f"Passwords saved to {passwords_output_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Split user:password pairs from a file into separate user and password files.")
    parser.add_argument("input_file", help="Path to the input file containing user:password pairs.")
    
    args = parser.parse_args()
    
    split_user_password(args.input_file)
