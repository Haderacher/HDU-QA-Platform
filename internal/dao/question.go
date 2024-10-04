package dao

import (
	"fmt"
	log "github.com/sirupsen/logrus"
	"gouse/internal/model"
	"gouse/utils"
)

func CreateQuestion(question *model.Question) error {
	// 用 Create 方法创建数据库
	if err := utils.GetDB().Model(&model.Question{}).Create(question).Error; err != nil {
		log.Errorf("CreateQuestion fail: %v", err)
		return fmt.Errorf("CreateUser fail: %v", err)
	}
	log.Infof("insert success")
	return nil
}
