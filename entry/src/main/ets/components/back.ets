import { router } from '@kit.ArkUI';

@Component
export struct TitleComponent {
  @StorageProp('topHeight') topHeight: number = 0
  title: string = ""

  build() {
    Row({ space: 20 }) {
      Image($r('app.media.back'))
        .width(14)
        .onClick(() => {
          router.back()
        })
      Text(this.title)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
    }
    .alignSelf(ItemAlign.Start)
    .padding({ top: this.topHeight })
  }
}