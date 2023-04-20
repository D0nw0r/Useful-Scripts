import os
import sys

dir = input("What is the directory: ")

print("\nDirectory "+dir+" has "+str(len(os.listdir(dir)))+" folders")
# print(os.listdir(dir))