@Component
export struct Learn {
  @State message: string = 'Hello World';

  build() {
    NavDestination() {
      Column() {
        Row().height(20)
        Row() {
          Column() {
            Text("今日复习")
            Text("0/0")
          }

          Column() {
            Text("今日新词")
            Text("0/0")
          }

          Column() {
            Text("学习时间")
            Text("1min")
          }
        }
        .width('100%')
        .borderRadius(2)
        .padding(16)
        .backgroundColor('#fff')
        .justifyContent(FlexAlign.SpaceBetween)
      }
    }
    .title("learn")
    .padding({
      top: 40,
      left: 40,
      right: 40
    })
    .linearGradient({
      colors: [
        [0xff00ffff, 0.0], // 颜色断点1的颜色和比重，对应组件在180°方向上的起始位置
        [0xffF8F9FB, 0.2],// 颜色断点2的颜色和比重，对应组件在180°方向上的终点位置
      ]
    })
  }
}