package main

import "fmt"

func __gophernotes(xx ...interface{}) {
	for _, x := range xx {
		fmt.Printf("%#v\n", x)
	}
}
func main()	{}
