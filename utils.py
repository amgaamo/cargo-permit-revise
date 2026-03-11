import re

def mask_custom_data(text):
    if not text:
        return text

    # 1. จัดการกรณี Email 
    if "@" in text:
        prefix, domain = text.split("@", 1)
        return f"{mask_logic(prefix)}@{domain}"
    
    # 2. จัดการกรณีข้อความทั่วไป หรือ ชื่อ-นามสกุล (แยกด้วยช่องว่าง)
    parts = text.split()
    masked_parts = [mask_logic(p) for p in parts]
    return " ".join(masked_parts)

def mask_logic(word):
    ln = len(word)
    
    # (1 ตัว: ไม่ Mask)
    if ln <= 1:
        return word
    
    #  (2 ตัว: เก็บหน้า 1 Mask 1)
    if ln == 2:
        return word[0] + "*"
    
    # (3 ตัว: เก็บหน้า 1 หลัง 1 ตรงกลาง Mask)
    if ln == 3:
        return word[0] + "*" + word[-1]
    
    # - 4 ตัวขึ้นไป: 
    # เก็บหน้า 2 หลัง 2 ตรงกลางเป็นดอกจันตามจำนวนที่เหลือ
    if ln >= 4:
        # ถ้าต้องการให้ rosalee (7 ตัว) ได้ดอกจัน 3 ตัว (ro***ee) ใช้สูตรนี้:
        return word[:2] + ("*" * (ln - 4)) + word[-2:]
    
    return word