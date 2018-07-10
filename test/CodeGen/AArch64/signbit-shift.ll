; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

; If positive...

define i32 @zext_ifpos(i32 %x) {
; CHECK-LABEL: zext_ifpos:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr w8, w0, #31
; CHECK-NEXT:    eor w0, w8, #0x1
; CHECK-NEXT:    ret
  %c = icmp sgt i32 %x, -1
  %e = zext i1 %c to i32
  ret i32 %e
}

define i32 @add_zext_ifpos(i32 %x) {
; CHECK-LABEL: add_zext_ifpos:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr w8, w0, #31
; CHECK-NEXT:    eor w8, w8, #0x1
; CHECK-NEXT:    add w0, w8, #41 // =41
; CHECK-NEXT:    ret
  %c = icmp sgt i32 %x, -1
  %e = zext i1 %c to i32
  %r = add i32 %e, 41
  ret i32 %r
}

define i32 @sel_ifpos_tval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifpos_tval_bigger:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, ge
; CHECK-NEXT:    ret
  %c = icmp sgt i32 %x, -1
  %r = select i1 %c, i32 42, i32 41
  ret i32 %r
}

define i32 @sext_ifpos(i32 %x) {
; CHECK-LABEL: sext_ifpos:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1
; CHECK-NEXT:    eor w0, w8, w0, asr #31
; CHECK-NEXT:    ret
  %c = icmp sgt i32 %x, -1
  %e = sext i1 %c to i32
  ret i32 %e
}

define i32 @add_sext_ifpos(i32 %x) {
; CHECK-LABEL: add_sext_ifpos:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr w8, w0, #31
; CHECK-NEXT:    eor w8, w8, #0x1
; CHECK-NEXT:    mov w9, #42
; CHECK-NEXT:    sub w0, w9, w8
; CHECK-NEXT:    ret
  %c = icmp sgt i32 %x, -1
  %e = sext i1 %c to i32
  %r = add i32 %e, 42
  ret i32 %r
}

define i32 @sel_ifpos_fval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifpos_fval_bigger:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, lt
; CHECK-NEXT:    ret
  %c = icmp sgt i32 %x, -1
  %r = select i1 %c, i32 41, i32 42
  ret i32 %r
}

; If negative...

define i32 @zext_ifneg(i32 %x) {
; CHECK-LABEL: zext_ifneg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr w0, w0, #31
; CHECK-NEXT:    ret
  %c = icmp slt i32 %x, 0
  %r = zext i1 %c to i32
  ret i32 %r
}

define i32 @add_zext_ifneg(i32 %x) {
; CHECK-LABEL: add_zext_ifneg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsr w8, w0, #31
; CHECK-NEXT:    add w0, w8, #41 // =41
; CHECK-NEXT:    ret
  %c = icmp slt i32 %x, 0
  %e = zext i1 %c to i32
  %r = add i32 %e, 41
  ret i32 %r
}

define i32 @sel_ifneg_tval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifneg_tval_bigger:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, lt
; CHECK-NEXT:    ret
  %c = icmp slt i32 %x, 0
  %r = select i1 %c, i32 42, i32 41
  ret i32 %r
}

define i32 @sext_ifneg(i32 %x) {
; CHECK-LABEL: sext_ifneg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    asr w0, w0, #31
; CHECK-NEXT:    ret
  %c = icmp slt i32 %x, 0
  %r = sext i1 %c to i32
  ret i32 %r
}

define i32 @add_sext_ifneg(i32 %x) {
; CHECK-LABEL: add_sext_ifneg:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #42
; CHECK-NEXT:    sub w0, w8, w0, lsr #31
; CHECK-NEXT:    ret
  %c = icmp slt i32 %x, 0
  %e = sext i1 %c to i32
  %r = add i32 %e, 42
  ret i32 %r
}

define i32 @sel_ifneg_fval_bigger(i32 %x) {
; CHECK-LABEL: sel_ifneg_fval_bigger:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, ge
; CHECK-NEXT:    ret
  %c = icmp slt i32 %x, 0
  %r = select i1 %c, i32 41, i32 42
  ret i32 %r
}
