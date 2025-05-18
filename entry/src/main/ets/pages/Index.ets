import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
  @StorageProp('topHeight') topHeight: number = 0

  build() {
    Scroll() {
      Column({ space: 18 }) {
        Row() {
          Text("学生服务")
            .fontColor('#fff')
            .fontWeight(500)
            .fontSize(22)
        }
        .height(48 + this.topHeight)
        .width('100%')
        .backgroundColor('#4f46e5')
        .padding({
          top: this.topHeight,
          left: 20
        })

        // 个人信息
        Row({ space: 12 }) {
          Image($r('app.media.icon'))
            .width(48)
            .height(48)
            .borderRadius(48)

          Column({ space: 4 }) {
            Text("欢迎回来")
              .fontSize(18)
              .fontColor("#111827")
              .fontWeight(500)
            Text("计算机科学与技术 · 2023级")
              .fontSize(16)
              .fontColor("#4b5563")
          }
          .alignItems(HorizontalAlign.Start)
        }
        .height(80)
        .width('90%')
        .borderRadius(12)
        .padding({ left: 12 })
        .backgroundColor("rgba(79,70,229,0.05)")

        // 奖学金情况
        Row({ space: 12 }) {
          Column({ space: 4 }) {
            Text("奖学金")
              .fontSize(18)
              .fontWeight(500)
              .fontColor("#111827")
            Text("22个可申请项目")
              .fontSize(16)
              .fontColor("#4b5563")

            Image($r("app.media.jicon"))
              .width(40)
              .margin({ top: 12 })
          }
          .padding(16)
          .alignItems(HorizontalAlign.Start)
          .height(140)
          .layoutWeight(1)
          .borderRadius(12)
          .linearGradient({
            direction: GradientDirection.RightBottom,
            colors: [["rgba(79,70,229,0.1)", 0], ["rgba(79,70,229,0.05)", 1]]
          })

          Column({ space: 6 }) {
            Text("助学金")
              .fontSize(18)
              .fontWeight(500)
              .fontColor("#111827")
            Text("8个资助项目")
              .fontSize(16)
              .fontColor("#4b5563")

            Image($r("app.media.zicon"))
              .width(40)
              .margin({ top: 12 })
          }
          .padding(16)
          .alignItems(HorizontalAlign.Start)
          .height(140)
          .layoutWeight(1)
          .borderRadius(12)
          .linearGradient({
            direction: GradientDirection.RightBottom,
            colors: [["rgba(234,179,8,0.1)", 0], ["rgba(234,179,8,0.05)", 1]]
          })
        }
        .width('90%')

        // 热门服务
        Column({ space: 18 }) {
          Text("热门服务")
            .fontSize(18)
            .fontWeight(500)
            .fontColor("#000")

          Row({ space: 20 }) {
            Column({ space: 12 }) {
              Image($r('app.media.jiangxuejing'))
                .width(48)
              Text("奖学金申请")
            }
            .onClick(() => {
              router.pushUrl({
                url: "pages/scholarship"
              })
            })

            Column({ space: 12 }) {
              Image($r('app.media.zhuxuejing'))
                .width(48)
              Text("助学金申请")
            }
            .onClick(() => {
              router.pushUrl({
                url: "pages/Stipend"
              })
            })

            Column({ space: 12 }) {
              Image($r('app.media.qingshi'))
                .width(48)
              Text("寝室置换")
            }
            .onClick(() => {
              router.pushUrl({
                url: "pages/Hostel"
              })
            })
          }
        }
        .width('90%')
        .alignItems(HorizontalAlign.Start)

        // 资助项目
        Column({ space: 20 }) {
          Text("资助项目")
            .fontSize(18)
            .fontWeight(500)
            .fontColor("#000")

          Row() {
            Column({ space: 12 }) {
              Flex({
                justifyContent: FlexAlign.SpaceBetween,
                alignItems: ItemAlign.Start,
              }) {
                Column() {
                  Text("国家助学金")
                    .fontColor("#000")
                    .fontSize(16)
                    .fontWeight(500)
                  Text("面向家庭经济困难的全日制本科生")
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)

                Text("申请中")
                  .backgroundColor("#4f46e5")
                  .fontColor("#fff")
                  .fontSize(14)
                  .padding(6)
                  .borderRadius(4)
              }
              .width('100%')

              Text("资助标准：3000 元/年")
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding(12)
          .width('100%')
          .height(114)
          .border({
            width: 1,
            color: "#eee",
          })
          .borderRadius(8)

          Row() {
            Column({ space: 12 }) {
              Flex({
                justifyContent: FlexAlign.SpaceBetween,
                alignItems: ItemAlign.Start,
              }) {
                Column() {
                  Text("专业奖学金")
                    .fontColor("#000")
                    .fontSize(16)
                    .fontWeight(500)
                  Text("计算机科学与技术专业优秀学生")
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)

                Text("已通过")
                  .backgroundColor("#16a34a")
                  .fontColor("#fff")
                  .fontSize(14)
                  .padding(6)
                  .borderRadius(4)
              }
              .width('100%')

              Text("资助标准：5000 元/年")
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding(12)
          .width('100%')
          .height(114)
          .border({
            width: 1,
            color: "#eee",
          })
          .borderRadius(8)
        }
        .width('90%')
        .alignItems(HorizontalAlign.Start)

      }
    }
  }
}