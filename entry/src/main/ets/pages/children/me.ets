import { router } from "@kit.ArkUI"

@Component
export struct MePage {
  @Consume navStack: NavPathStack;
  @StorageProp('userPhone') userPhone: string = ""

  @Styles
  cardStyle(){
    .borderRadius(8)
    .backgroundColor("#fff")
    .padding(16)
    .width('100%')
  }

  @Builder
  NextPage(title: string, callback?: Function) {
    Row() {
      Text(title)
        .fontSize(16)
        .layoutWeight(1)

      Image($r('app.media.next'))
        .width(16)
    }.onClick(() => {
      callback?.()
    })
  }

  build() {
    Column({ space: 20 }) {
      Row().height(40)
      Row({ space: 20 }) {
        Image($r('app.media.ic_avatar'))
          .width(45)
        Text(`${this.userPhone}`).fontWeight(FontWeight.Bold)
      }

      Column({ space: 24 }) {
        this.NextPage("错题本", () => {
          this.navStack.pushPathByName('errorText', undefined)
        })
        this.NextPage("我的学习", () => {
          this.navStack.pushPathByName('hasLearn', undefined)
        })
      }
      .alignItems(HorizontalAlign.Start)
      .cardStyle()

      Button("退出登录")
        .width('100%')
        .height(48)
        .margin({ top: 70 })
        .onClick(() => {
          router.replaceUrl({
            url: "pages/Login"
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