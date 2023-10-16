import argparse

def format_usernames(usernames):
    formatted_usernames = []
    for username in usernames:
        parts = username.split()  # Split the username into parts using spaces as separator

        if len(parts) == 1:
            # If it's a single name, just append it as it is or lowercase
            formatted_usernames.append(username)

            formatted_usernames.append(str(username).lower())
            
        if len(parts) == 2:
            first_name, last_name = parts[0], parts[1]
            # Rule 1: FirstName.LastName
            formatted_usernames.append(f"{first_name}.{last_name}")
            
            # Rule 2: FirstLetterofFirstName.LastName
            formatted_usernames.append(f"{first_name[0]}.{last_name}")
            
            # Rule 3: firstname.lastname (lowercase)
            formatted_usernames.append(f"{first_name.lower()}.{last_name.lower()}")
            
            # Rule 4: firstletteroffirstname.lastname (lowercase)
            formatted_usernames.append(f"{first_name[0].lower()}.{last_name.lower()}")
            
            # Rule 5: FirstName-LastName
            formatted_usernames.append(f"{first_name}-{last_name}")
            
            # Rule 6: FirstLetterofFirstName-LastName
            formatted_usernames.append(f"{first_name[0]}-{last_name}")

            # Rule 7: FirstNameLastName
            formatted_usernames.append(f"{first_name}{last_name}")

            # Rule 7: FirstNameLastName (lowercase)
            formatted_usernames.append(f"{first_name.lower()}{last_name.lower()}")

            # Rule 8: FirstLetterofFirstNameLastName
            formatted_usernames.append(f"{first_name[0]}{last_name}")

            # Rule 8: FirstLetterofFirstName-LastName
            formatted_usernames.append(f"{first_name[0]}-{last_name}")
            
            # You can add more formatting rules here as needed
            
        # else:
        #     # Handle invalid username format
        #     formatted_usernames.append(f"Invalid: {username}")
    
    return formatted_usernames

def main():
    parser = argparse.ArgumentParser(description='Format a list of usernames from a file')
    parser.add_argument('filename', help='File containing usernames, one per line')
    args = parser.parse_args()
    
    try:
        with open(args.filename, 'r') as file:
            usernames = file.read().splitlines()
    except FileNotFoundError:
        print(f"Error: File '{args.filename}' not found.")
        return
    
    formatted_usernames = format_usernames(usernames)

    for formatted_username in formatted_usernames:
        print(formatted_username)

if __name__ == "__main__":
    main()
