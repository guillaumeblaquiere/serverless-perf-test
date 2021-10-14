package function

import (
	"fmt"
	"net/http"
	"strconv"
)

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
