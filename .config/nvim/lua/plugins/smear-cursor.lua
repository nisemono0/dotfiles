return {
    "sphamba/smear-cursor.nvim",
    opts = {
        -- 17~60fps; 8~120fps; 7~144fps; 5~180fps
        time_interval = 7,
        legacy_computing_symbols_support = true,
        stiffness = 0.8,
        trailing_stiffness = 0.6,
        stiffness_insert_mode = 0.7,
        trailing_stiffness_insert_mode = 0.7,
        damping = 0.95,
        damping_insert_mode = 0.95,
        distance_stop_animating = 0.5,
    },
}

