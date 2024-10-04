package utils

import (
	"gorm.io/gorm"
	"reflect"
	"testing"
)

func TestGetDB(t *testing.T) {
	var tests []struct {
		name string
		want *gorm.DB
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := GetDB(); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("GetDB() = %v, want %v", got, tt.want)
			}
		})
	}
}
