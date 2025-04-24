import { router } from "@kit.ArkUI"

@Component
export struct MePage {
  @Styles
  cardStyle(){
    .borderRadius(8)
    .backgroundColor("#fff")
    .padding(16)
    .width('100%')
  }

  @Builder
  NextPage(title: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .layoutWeight(1)

      Image($r('app.media.next'))
        .width(16)
    }
  }

  build() {
    Column({ space: 20 }) {
      Row().height(40)
      Row({ space: 20 }) {
        Image($r('app.media.ic_avatar'))
          .width(45)

        Text("135****69").fontWeight(FontWeight.Bold)
      }

      Row({ space: 12 }) {
        Text('累计已学 0  ,   坚持 0 天')
          .fontSize(18)
      }
      .cardStyle()

      Column({ space: 24 }) {
        this.NextPage("我的日历")
        this.NextPage("我的学习")
        this.NextPage("我的词汇量")
      }
      .alignItems(HorizontalAlign.Start)
      .cardStyle()

      Column({ space: 24 }) {
        this.NextPage("我的搜藏")
        this.NextPage("我的图书")
        this.NextPage("我的阅读")
      }
      .alignItems(HorizontalAlign.Start)
      .cardStyle()


      Button("退出登录")
        .width('100%')
        .height(48)
        .margin({top:70})
        .onClick(()=>{
          router.replaceUrl({
            url:"pages/Login"
          })
        })

    }
    .width('100%')
    .height('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
  }
}