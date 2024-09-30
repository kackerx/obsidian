:::::::::::::::::::::::::::::::::::::::: {.columns border=off col-count=2 largest-column=firs}

~~~ad-grey
title: app

```ts
<script setup lang="ts">

import useMousePosition from './hooks/useMousePosition'

const { x, y } = useMousePosition() // 功能函数抽离出来, 使用导出的结果


</script>

<template>
  <div>{{ x }} - {{ y }}</div>
</template>
```
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::columnbreak
:::

~~~ad-primary
title: @hooks/useMousePosition.ts

```ts
import { onMounted, onUnmounted, ref } from 'vue'

const useMousePosition = () => {
    const x = ref(0)
    const y = ref(0)


    const updateMouse = (e: MouseEvent) => {
        x.value = e.pageX
        y.value = e.pageY
    }
    onMounted(() => {
        document.addEventListener('click', updateMouse)
    })

    onUnmounted(() => {
        document.removeEventListener('click', updateMouse)
    })

    return { x, y }
}

export default useMousePosition
```
~~~

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::