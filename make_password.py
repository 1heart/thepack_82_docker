import hashlib
import sys

salt = "fbc1993a5b1af39e648afe807482bea4"


if __name__ == "__main__":
    password = sys.argv[1]
    print(hashlib.sha512(password + salt).hexdigest())
