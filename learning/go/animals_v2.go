package main

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"os"
	"reflect"
	"strconv"
	"strings"
)

type Animal interface {
	Eat()
	Move()
	Speak()
}

type Cow struct {
	food       string
	locomotion string
	noise      string
}

func (c *Cow) Init() {
	c.food = "grass"
	c.locomotion = "walk"
	c.noise = "moo"
}

func (c Cow) Eat() {
	fmt.Println(c.food)
}

func (c Cow) Move() {
	fmt.Println(c.locomotion)
}

func (c Cow) Speak() {
	fmt.Println(c.noise)
}

type Bird struct {
	food       string
	locomotion string
	noise      string
}

func (b *Bird) Init() {
	b.food = "worms"
	b.locomotion = "fly"
	b.noise = "peep"
}

func (b Bird) Eat() {
	fmt.Println(b.food)
}

func (b Bird) Move() {
	fmt.Println(b.locomotion)
}

func (b Bird) Speak() {
	fmt.Println(b.noise)
}

type Snake struct {
	food       string
	locomotion string
	noise      string
}

func (s *Snake) Init() {
	s.food = "mice"
	s.locomotion = "slither"
	s.noise = "hsss"
}

func (s Snake) Eat() {
	fmt.Println(s.food)
}

func (s Snake) Move() {
	fmt.Println(s.locomotion)
}

func (s Snake) Speak() {
	fmt.Println(s.noise)
}

func DisplayQueryResult(a Animal, name string, action string) {
	var aTypeStr string
	switch t := a.(type) {
	case Cow:
		aTypeStr = "cow"
	case Bird:
		aTypeStr = "bird"
	case Snake:
		aTypeStr = "snake"
	default:
		aTypeStr = "unknown animal"
		fmt.Printf("unexpected type: %T value: '%v' (%s)\n", t, t, aTypeStr)
	}
	switch action {
	case "eat":
		fmt.Printf("%s (%s) food eaten: ", name, aTypeStr)
		a.Eat()
	case "move":
		fmt.Printf("%s (%s) locomotion method: ", name, aTypeStr)
		a.Move()
	case "speak":
		fmt.Printf("%s (%s) spoken sound: ", name, aTypeStr)
		a.Speak()
	}
}

func PrintUsage() {
	fmt.Println("Find out what your animals eat, move, and speak.")
	fmt.Println("*********************************************************")
	fmt.Println("Create syntax: newanimal <name> <type: cow, bird, snake>")
	fmt.Println("For example:")
	fmt.Println("> newanimal betty bird")
	fmt.Println("")
	fmt.Println("Query syntax: query <name> <action: eat, move, speak")
	fmt.Println("For example:")
	fmt.Println("> query betty speak")
	fmt.Println("*********************************************************")
	fmt.Println("")
	fmt.Println("Enter 'x' to quit")
}

func ParseInput(in string) (cmd string, arg1 string, arg2 string, err error) {
	tokens := strings.Split(in, " ")
	if len(tokens) != 3 {
		return "", "", "", errors.New("command syntax: number of tokens is != 3 ")
	}
	if !(strings.EqualFold(tokens[0], "newanimal") ||
		strings.EqualFold(tokens[0], "query")) {
		return "", "", "", errors.New("unsupported command: " + tokens[0])
	}
	if strings.EqualFold(tokens[0], "newanimal") {
		if !(strings.EqualFold(tokens[2], "cow") ||
			strings.EqualFold(tokens[2], "bird") ||
			strings.EqualFold(tokens[2], "snake")) {
			return "", "", "", errors.New("unsupported animal: " + tokens[2])
		}
	}
	if strings.EqualFold(tokens[0], "query") {
		if !(strings.EqualFold(tokens[2], "eat") ||
			strings.EqualFold(tokens[2], "move") ||
			strings.EqualFold(tokens[2], "speak")) {
			return "", "", "", errors.New("unsupported action: " + tokens[2])
		}
	}
	return tokens[0], tokens[1], tokens[2], nil
}

func unit_test_01() {
	c := Cow{}
	b := Bird{}
	s := Snake{}
	c.Init()
	b.Init()
	s.Init()
	animals := []Animal{c, b, s}
	for i, val := range animals {
		fmt.Println("type=", reflect.TypeOf(val))
		name := "animal_" + strconv.Itoa(i)
		DisplayQueryResult(val, name, "eat")
		DisplayQueryResult(val, name, "move")
		DisplayQueryResult(val, name, "speak")
	}
}

func unit_test_02(cmd string, arg1 string, arg2 string) {
	fmt.Println("cmd=", cmd)
	fmt.Println("arg1=", arg1)
	fmt.Println("arg2=", arg2)
}

func main() {
	keepEnt := true
	PrintUsage()
	animals := make(map[string]interface{})
	for keepEnt {
		fmt.Printf("> ")
		reader := bufio.NewReader(os.Stdin)
		in, _ := reader.ReadString('\n')
		in = strings.TrimSpace(in)
		in = strings.TrimSuffix(in, "\n")
		in = strings.ToLower(in)
		if in == "x" {
			break
		} else {
			cmd, arg1, arg2, err := ParseInput(in)
			if err != nil {
				log.Fatal(err)
			}
			if cmd == "newanimal" {
				switch {
				case arg2 == "cow":
					c := Cow{}
					c.Init()
					animals[arg1] = c
				case arg2 == "bird":
					b := Bird{}
					b.Init()
					animals[arg1] = b
				case arg2 == "snake":
					s := Snake{}
					s.Init()
					animals[arg1] = s
				default:
					log.Fatal("Could not created animal: " + arg2)
				}
				fmt.Println("Created it!")
			}
			if cmd == "query" {
				// The following doesn't work, why?
				// DisplayQueryResult(animals[arg1]interface{}, arg1, arg2)
				// Reason: You need to convert animals[arg1] to type Animal
				//         because function does not know what interface{} is
				DisplayQueryResult(animals[arg1].(Animal), arg1, arg2)
			}
		}
		//for key, element := range animals {
		//	fmt.Println("Key:", key, "=>", "Val:", element, "ValType:", reflect.TypeOf(element))
		//
		//}
	}
	fmt.Printf("Done.\n")
}
