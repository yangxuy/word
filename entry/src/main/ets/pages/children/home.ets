@Component
export struct HomePage {
  @Consume navStack: NavPathStack;

  build() {
    Column({ space: 20 }) {
      Row().height(68)
      Text('已打卡天数')
      Text('0').fontSize(24).fontWeight(FontWeight.Bold)
      Row().height(30)

      Column() {
        Row() {
          Text("四级真题核心词汇书")
          Text("词表")
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(20)
        Row() {
          Text("已学0.0%")
          Text("0/1654词")
            .fontSize(12)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        Row().height(8)
        Progress({ value: 24, total: 100, type: ProgressType.Linear })
      }
      .borderRadius(8)
      .backgroundColor("#fff")
      .padding(16)
      .width('100%')

      Row().height(80)
      Button("开始学习")
        .width('100%')
        .height(54)
        .fontColor('#fff')
        .backgroundColor('#A033A634')
        .onClick(() => {
          this.navStack.pushPathByName('learn', undefined)
        })

      Button("开始考试")
        .width('100%')
        .height(54)
        .fontColor('#fff')
        .backgroundColor('#A033A634')
        .onClick(() => {
          this.navStack.pushPathByName('exam', undefined)
        })
    }
    .padding({
      top: 50,
      left: 16,
      right: 16
    })
    .height('100%')
    .width('100%')
  }
}