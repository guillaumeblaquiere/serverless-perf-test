package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
)

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	http.HandleFunc("/", Fibonacci)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}

func Fibonacci(w http.ResponseWriter, r *http.Request) {
	var n int64 = 30
	param := r.URL.Query().Get("n")
	if p, err := strconv.Atoi(param); err == nil {
		n = int64(p)
	}
	fmt.Fprintf(w, "Fibonacci(%d) = %d", n, fibo(n))
}

func fibo(n int64) int64 {
	if n <= 2 {
		return n - 1
	} else {
		return fibo(n-1) + fibo(n-2)
	}
}
