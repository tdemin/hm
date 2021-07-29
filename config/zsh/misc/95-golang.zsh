export CGO_ENABLED=0

export GOFLAGS=-modcacherw

go-temp () {
    command cat >"go.mod"<<EOF
    module testing_program
    go 1.16
EOF
    command cat >"main.go"<<EOF
package main

import "fmt"

func main() {
    fmt.Printf("%s\n", "Temp dir")
}
EOF
    command cat >"main_test.go"<<EOF
package main

import "testing"

func BenchmarkX(b *testing.B) {
    for i := 0; i < b.N; i++ {}
}

func TestX(t *testing.T) {
    var tests = []struct{
        name string
        want interface{}
    }{}
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            ans := func() int {
                return 42
            }()
            if tt.want != ans {
                t.Errorf("got %d, want %d", ans, tt.want)
            }
        })
    }
}
EOF
}
