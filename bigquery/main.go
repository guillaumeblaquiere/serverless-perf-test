package main

import (
	"fmt"
	"math/rand"
	"os"
)

func main() {
	f, _ := os.Create("./data.csv")
	defer f.Close()
	f.Write([]byte("random_number\n"))
	for i := 0; i < 10000; i++ {
		fmt.Println(i)
		d1 := generateContent()
		f.Write(d1)
	}
}

func generateContent() []byte {
	output := ""
	for i := 0; i < 100; i++ {
		nb := rand.Intn(10)*100000000 + rand.Intn(10)*1000000 + rand.Intn(10)*10000 + rand.Intn(10)*1000 + rand.Intn(1000)
		output += fmt.Sprintf("%d\n", nb)
	}
	return []byte(output)
}
